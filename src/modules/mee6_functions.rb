def get_lvl_xp(xp)
  5 * (xp**2) + 50 * xp + 100
end

def get_xp_info(player)
  remaining = player['xp']
  level = 0
  while remaining >= get_lvl_xp(level)
    remaining -= get_lvl_xp(level)
    level += 1
  end
  OpenStruct.new(
    name: "#{player['username']}##{player['discriminator']}",
    level: level,
    total_xp: player['xp'],
    remaining: remaining,
    level_xp_max: get_lvl_xp(level),
    xp: get_lvl_xp(level) - remaining,
    percent: (get_lvl_xp(level) - remaining) * 100 / get_lvl_xp(level)
  )
end
