#!/usr/bin/env python3
"""Dependency-free fresh-process benchmark runner for this Neovim config."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import re
import shutil
import statistics
import subprocess
import tempfile
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
PROBE = ROOT / "bench" / "probe.lua"
FIXTURES = {
    "empty": None,
    "lua": ROOT / "bench" / "fixtures" / "completion.lua",
    "markdown": ROOT / "bench" / "fixtures" / "completion.md",
}
STARTUP_RE = re.compile(r"^\s*([0-9.]+).*NVIM STARTED", re.MULTILINE)
ALLOWED_NEW_STARTUP_PLUGINS = {"sidekick.nvim"}


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def config_hash() -> str:
    paths = [ROOT / "init.lua"]
    paths.extend(sorted((ROOT / "lua").rglob("*.lua")))
    paths.extend(sorted((ROOT / "after").rglob("*.lua")))
    digest = hashlib.sha256()
    for path in paths:
        digest.update(path.relative_to(ROOT).as_posix().encode())
        digest.update(b"\0")
        digest.update(path.read_bytes())
        digest.update(b"\0")
    return digest.hexdigest()


def command_output(command: list[str]) -> str:
    return subprocess.check_output(command, cwd=ROOT, text=True).strip()


def percentile(values: list[float], quantile: float) -> float:
    if not values:
        raise ValueError("cannot summarize an empty sample")
    ordered = sorted(values)
    position = (len(ordered) - 1) * quantile
    lower = int(position)
    upper = min(lower + 1, len(ordered) - 1)
    fraction = position - lower
    return ordered[lower] + (ordered[upper] - ordered[lower]) * fraction


def summary(values: list[float]) -> dict[str, float | int]:
    median = statistics.median(values)
    return {
        "count": len(values),
        "p50_ms": round(median, 3),
        "p95_ms": round(percentile(values, 0.95), 3),
        "mad_ms": round(statistics.median(abs(value - median) for value in values), 3),
        "min_ms": round(min(values), 3),
        "max_ms": round(max(values), 3),
    }


def ensure_link(link: Path, target: Path) -> None:
    link.parent.mkdir(parents=True, exist_ok=True)
    if not target.exists():
        return
    link.symlink_to(target, target_is_directory=target.is_dir())


def isolated_environment(base: Path) -> tuple[dict[str, str], str]:
    appname = "bench-nvim"
    config_home = base / "config"
    data_home = base / "data"
    state_home = base / "state"
    cache_home = base / "cache"
    for path in (config_home, data_home, state_home, cache_home):
        path.mkdir(parents=True, exist_ok=True)

    ensure_link(config_home / appname, ROOT)
    source_data = Path.home() / ".local" / "share" / "nvim"
    ensure_link(data_home / appname / "lazy", source_data / "lazy")
    ensure_link(data_home / appname / "mason", source_data / "mason")

    env = os.environ.copy()
    env.update(
        {
            "NVIM_APPNAME": appname,
            "XDG_CONFIG_HOME": str(config_home),
            "XDG_DATA_HOME": str(data_home),
            "XDG_STATE_HOME": str(state_home),
            "XDG_CACHE_HOME": str(cache_home),
            "GIT_TERMINAL_PROMPT": "0",
            "BENCH_ROOT": str(ROOT),
        }
    )
    return env, appname


def sandbox_prefix() -> list[str]:
    tool = shutil.which("sandbox-exec")
    if platform.system() != "Darwin" or not tool:
        return []
    data = Path.home() / ".local" / "share" / "nvim"
    profile = (
        "(version 1) (allow default) (deny network*) "
        f'(deny file-write* (subpath "{data / "lazy"}") (subpath "{data / "mason"}"))'
    )
    return [tool, "-p", profile]


def nvim_command(
    env: dict[str, str],
    mode: str,
    record: Path,
    fixture: Path | None = None,
    startuptime: Path | None = None,
    completion_count: int = 1,
) -> list[str]:
    run_env = env.copy()
    run_env.update(
        {
            "BENCH_MODE": mode,
            "BENCH_RECORD": str(record),
            "BENCH_COMPLETION_COUNT": str(completion_count),
        }
    )
    env.clear()
    env.update(run_env)
    command = [*sandbox_prefix(), "nvim", "--headless", "-i", "NONE"]
    if startuptime:
        command.extend(["--startuptime", str(startuptime)])
    command.extend(["--cmd", f"lua dofile({json.dumps(str(PROBE))})"])
    if fixture:
        command.append(str(fixture))
    return command


def run_nvim(
    env: dict[str, str],
    mode: str,
    record: Path,
    fixture: Path | None = None,
    startuptime: Path | None = None,
    completion_count: int = 1,
    timeout: int = 20,
) -> subprocess.CompletedProcess[str]:
    record.parent.mkdir(parents=True, exist_ok=True)
    if startuptime:
        startuptime.parent.mkdir(parents=True, exist_ok=True)
    local_env = env.copy()
    command = nvim_command(local_env, mode, record, fixture, startuptime, completion_count)
    process = subprocess.run(
        command,
        cwd=ROOT,
        env=local_env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        timeout=timeout,
    )
    if process.returncode != 0:
        raise RuntimeError(
            f"Neovim benchmark failed ({mode}, {fixture}):\n"
            f"command: {' '.join(command)}\nstdout:\n{process.stdout}\nstderr:\n{process.stderr}"
        )
    return process


def read_records(path: Path) -> list[dict[str, Any]]:
    if not path.exists():
        raise RuntimeError(f"benchmark probe did not create {path}")
    records = []
    for line in path.read_text().splitlines():
        if line.strip():
            records.append(json.loads(line))
    return records


def startup_ms(path: Path) -> float:
    matches = STARTUP_RE.findall(path.read_text(errors="replace"))
    if not matches:
        raise RuntimeError(f"no NVIM STARTED marker in {path}")
    return float(matches[-1])


def git_metadata() -> dict[str, Any]:
    diff = subprocess.check_output(["git", "diff", "--", "lazy-lock.json"], cwd=ROOT)
    return {
        "branch": command_output(["git", "branch", "--show-current"]),
        "head": command_output(["git", "rev-parse", "HEAD"]),
        "masterj": command_output(["git", "rev-parse", "masterj"]),
        "lock_diff_sha256": hashlib.sha256(diff).hexdigest(),
    }


def manifest(label: str, args: argparse.Namespace) -> dict[str, Any]:
    dictionary = Path("/usr/share/dict/words")
    resolved_dictionary = dictionary.resolve() if dictionary.exists() else None
    return {
        "label": label,
        "protocol": "fresh-process/warm-cache",
        "runs": args.runs,
        "warmups": args.warmups,
        "completion_first_use_runs": 10,
        "completion_steady_runs": 50,
        "machine": {
            "platform": platform.platform(),
            "machine": platform.machine(),
            "processor": platform.processor(),
        },
        "python": platform.python_version(),
        "nvim": command_output(["nvim", "--version"]).splitlines()[0],
        "config_sha256": config_hash(),
        "lock_sha256": sha256_file(ROOT / "lazy-lock.json"),
        "dictionary": str(dictionary),
        "dictionary_resolved": str(resolved_dictionary) if resolved_dictionary else None,
        "git": git_metadata(),
        "network_sandbox": bool(sandbox_prefix()),
    }


def capture(args: argparse.Namespace) -> None:
    output = Path(args.output)
    if not output.is_absolute():
        output = ROOT / output
    raw_root = output.parent / "raw" / args.label
    if raw_root.exists():
        shutil.rmtree(raw_root)
    raw_root.mkdir(parents=True)

    data: dict[str, Any] = {"manifest": manifest(args.label, args), "startup": {}, "completion": {}, "ai": []}
    with tempfile.TemporaryDirectory(prefix="nvim-bench-") as temp:
        env, _ = isolated_environment(Path(temp))

        for scenario, fixture in FIXTURES.items():
            scenario_root = raw_root / "startup" / scenario
            for warmup in range(args.warmups):
                run_nvim(
                    env,
                    "startup",
                    scenario_root / f"warmup-{warmup + 1:02d}.jsonl",
                    fixture,
                    scenario_root / f"warmup-{warmup + 1:02d}.log",
                )
            samples = []
            for run in range(args.runs):
                record = scenario_root / f"sample-{run + 1:02d}.jsonl"
                trace = scenario_root / f"startuptime-{run + 1:02d}.log"
                run_nvim(env, "startup", record, fixture, trace)
                probe_records = read_records(record)
                samples.append(
                    {
                        "run": run + 1,
                        "startuptime_ms": startup_ms(trace),
                        "trace": str(trace.relative_to(ROOT)),
                        "probe": probe_records[-1],
                    }
                )
            values = [sample["startuptime_ms"] for sample in samples]
            data["startup"][scenario] = {"summary": summary(values), "samples": samples}

        completion_root = raw_root / "completion"
        first_use = []
        for run in range(10):
            record = completion_root / f"first-use-{run + 1:02d}.jsonl"
            run_nvim(env, "completion", record, FIXTURES["lua"], completion_count=1)
            records = read_records(record)
            if len(records) != 1:
                raise RuntimeError(f"expected one first-use completion record, got {len(records)}")
            first_use.append(records[0])

        steady_record = completion_root / "steady.jsonl"
        run_nvim(env, "completion", steady_record, FIXTURES["lua"], completion_count=50, timeout=60)
        steady = read_records(steady_record)
        if len(steady) != 50:
            raise RuntimeError(f"expected 50 steady completion records, got {len(steady)}")

        for name, records in (("first_use", first_use), ("steady", steady)):
            failures = [record for record in records if record.get("timeout") or record.get("error")]
            values = [float(record["elapsed_ms"]) for record in records if "elapsed_ms" in record]
            data["completion"][name] = {
                "summary": summary(values),
                "failures": failures,
                "samples": records,
            }
            if failures:
                raise RuntimeError(f"{name} completion correctness failure: {failures[0]}")

        if args.ai:
            record = raw_root / "ai" / "events.jsonl"
            try:
                run_nvim(env, "ai", record, FIXTURES["lua"], timeout=45)
                data["ai"] = read_records(record)
            except Exception as error:  # external auth/provider failures stay explicit
                data["ai"] = [{"status": "failed", "error": str(error)}]

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n")
    print(f"wrote {output}")


def metric_gate(current: float, baseline: float, absolute: float, ratio: float) -> bool:
    return current > baseline + absolute and current > baseline * ratio


def loaded_plugins(sample: dict[str, Any]) -> set[str]:
    snapshots = sample["probe"].get("snapshots", {})
    snapshot = snapshots.get("very_lazy") or snapshots.get("vim_enter") or snapshots.get("after_file") or {}
    return {plugin["name"] for plugin in snapshot.get("plugins", []) if plugin.get("loaded")}


def compare(args: argparse.Namespace) -> None:
    baseline_path = Path(args.baseline)
    current_path = Path(args.current)
    if not baseline_path.is_absolute():
        baseline_path = ROOT / baseline_path
    if not current_path.is_absolute():
        current_path = ROOT / current_path
    baseline = json.loads(baseline_path.read_text())
    current = json.loads(current_path.read_text())

    report: dict[str, Any] = {
        "baseline": baseline["manifest"]["label"],
        "current": current["manifest"]["label"],
        "startup": {},
        "completion": {},
        "loaded_plugin_increases": {},
        "gates_passed": True,
    }
    for scenario in FIXTURES:
        before = baseline["startup"][scenario]["summary"]
        after = current["startup"][scenario]["summary"]
        p50_fail = metric_gate(after["p50_ms"], before["p50_ms"], 10.0, 1.05)
        p95_fail = metric_gate(after["p95_ms"], before["p95_ms"], 20.0, 1.10)
        improvement = (
            after["p50_ms"] <= before["p50_ms"] - 5.0
            and after["p50_ms"] <= before["p50_ms"] * 0.95
        )
        report["startup"][scenario] = {
            "baseline": before,
            "current": after,
            "p50_regression": p50_fail,
            "p95_regression": p95_fail,
            "improvement": improvement,
        }
        report["gates_passed"] = report["gates_passed"] and not p50_fail and not p95_fail

        before_loaded = loaded_plugins(baseline["startup"][scenario]["samples"][0])
        after_loaded = loaded_plugins(current["startup"][scenario]["samples"][0])
        added = sorted(after_loaded - before_loaded)
        unexplained = sorted(set(added) - ALLOWED_NEW_STARTUP_PLUGINS)
        report["loaded_plugin_increases"][scenario] = {"added": added, "unexplained": unexplained}
        report["gates_passed"] = report["gates_passed"] and not unexplained

    for phase in ("first_use", "steady"):
        before = baseline["completion"][phase]["summary"]
        after = current["completion"][phase]["summary"]
        failures = current["completion"][phase]["failures"]
        p50_fail = metric_gate(after["p50_ms"], before["p50_ms"], 5.0, 1.10)
        p95_fail = metric_gate(after["p95_ms"], before["p95_ms"], 5.0, 1.10)
        report["completion"][phase] = {
            "baseline": before,
            "current": after,
            "correctness_failures": failures,
            "p50_regression": p50_fail,
            "p95_regression": p95_fail,
        }
        report["gates_passed"] = report["gates_passed"] and not failures and not p50_fail and not p95_fail

    json_path = Path(args.json)
    markdown_path = Path(args.markdown)
    if not json_path.is_absolute():
        json_path = ROOT / json_path
    if not markdown_path.is_absolute():
        markdown_path = ROOT / markdown_path
    json_path.parent.mkdir(parents=True, exist_ok=True)
    json_path.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")

    rows = [
        "# Neovim benchmark comparison",
        "",
        f"Baseline: `{report['baseline']}`. Current: `{report['current']}`.",
        "",
        "## Startup (fresh process, warm filesystem cache)",
        "",
        "| Scenario | Baseline p50 | Current p50 | Baseline p95 | Current p95 | Gate |",
        "| --- | ---: | ---: | ---: | ---: | --- |",
    ]
    for scenario, result in report["startup"].items():
        gate = "FAIL" if result["p50_regression"] or result["p95_regression"] else "pass"
        rows.append(
            f"| {scenario} | {result['baseline']['p50_ms']:.3f} ms | {result['current']['p50_ms']:.3f} ms | "
            f"{result['baseline']['p95_ms']:.3f} ms | {result['current']['p95_ms']:.3f} ms | {gate} |"
        )
    rows.extend(
        [
            "",
            "## Completion",
            "",
            "| Phase | Baseline p50 | Current p50 | Baseline p95 | Current p95 | Gate |",
            "| --- | ---: | ---: | ---: | ---: | --- |",
        ]
    )
    for phase, result in report["completion"].items():
        gate = "FAIL" if result["p50_regression"] or result["p95_regression"] or result["correctness_failures"] else "pass"
        rows.append(
            f"| {phase} | {result['baseline']['p50_ms']:.3f} ms | {result['current']['p50_ms']:.3f} ms | "
            f"{result['baseline']['p95_ms']:.3f} ms | {result['current']['p95_ms']:.3f} ms | {gate} |"
        )
    rows.extend(["", f"Overall gates: **{'pass' if report['gates_passed'] else 'FAIL'}**.", ""])
    markdown_path.write_text("\n".join(rows))
    print(f"wrote {json_path}")
    print(f"wrote {markdown_path}")
    if not report["gates_passed"]:
        raise SystemExit(1)


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser(description=__doc__)
    subparsers = root.add_subparsers(dest="command", required=True)
    capture_parser = subparsers.add_parser("capture")
    capture_parser.add_argument("--label", required=True)
    capture_parser.add_argument("--runs", type=int, default=30)
    capture_parser.add_argument("--warmups", type=int, default=5)
    capture_parser.add_argument("--output", required=True)
    capture_parser.add_argument("--ai", action="store_true")
    capture_parser.set_defaults(func=capture)

    compare_parser = subparsers.add_parser("compare")
    compare_parser.add_argument("baseline")
    compare_parser.add_argument("current")
    compare_parser.add_argument("--json", required=True)
    compare_parser.add_argument("--markdown", required=True)
    compare_parser.set_defaults(func=compare)
    return root


def main() -> None:
    args = parser().parse_args()
    if getattr(args, "runs", 1) < 1 or getattr(args, "warmups", 0) < 0:
        raise SystemExit("runs must be positive and warmups non-negative")
    args.func(args)


if __name__ == "__main__":
    main()
