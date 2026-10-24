local M = {}

---@param opts kataware.Config
function M.setup(opts)
  -- One restrained luminance ladder, with spectral accents reserved for meaning.
  local p = {
    void = '#0B1020',
    night = '#10172A',
    surface = '#151F38',
    surface_high = '#1D2A49',
    border = '#2B3B62',
    muted = '#6B7FA2',
    dim = '#A8B7D0',
    fg = '#D9E2F2',
    starlight = '#EEF3FF',
    comet = '#60D7E8',
    blue = '#6CA8FF',
    violet = '#9B8CFF',
    pink = '#F08BC3',
    red = '#F2778B',
    gold = '#F2C38B',
    green = '#82D2B2',
    diff = {
      add = '#142C31',
      change = '#182846',
      delete = '#2D192A',
      text = '#253A68',
    },
    diagnostic = {
      error = '#241625',
      warn = '#28243A',
      info = '#172442',
      hint = '#14283A',
    },
    terminal_bright = {
      red = '#FF91A4',
      green = '#A0E0C2',
      gold = '#FFD49F',
      blue = '#91BAFF',
      violet = '#B9ACFF',
      comet = '#86E9F2',
    },
  }

  if opts.on_colors then
    opts.on_colors(p)
  end

  -- Shared surfaces keep transparency consistent across core and plugin groups.
  p.bg = opts.transparent and 'NONE' or p.void
  p.bg_float = opts.transparent and 'NONE' or p.surface
  p.bg_float_high = opts.transparent and 'NONE' or p.surface_high
  p.bg_scrollbar = opts.transparent and 'NONE' or p.night
  p.terminal = {
    p.void, p.red, p.green, p.gold, p.blue, p.violet, p.comet, p.dim,
    p.muted, p.terminal_bright.red, p.terminal_bright.green, p.terminal_bright.gold,
    p.terminal_bright.blue, p.terminal_bright.violet, p.terminal_bright.comet, p.starlight,
  }
  return p
end

return M
