local benchmarkCompletionTarget = 'deterministic-buffer-source-item'
local benchmarkCompletionTargetSecondary = benchmarkCompletionTarget .. '-secondary'

local function render(value)
  return value .. benchmarkCompletionTargetSecondary
end

local measured = benchmarkCompletionTarge
