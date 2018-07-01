def get_lvl_xp(lvl)
  5 * lvl**2 + 50 * lvl + 100
end

def get_xp_info(player)
  remaining = player['xp']
  level = 0
  while remaining >= get_lvl_xp(level)
    remaining -= get_lvl_xp(level)
    level += 1
  end
  OpenStruct.new(
    name: "#{player['username'][0...15]}##{player['discriminator']}",
    level: level,
    total_xp: player['xp'],
    remaining: get_lvl_xp(level) - remaining,
    level_xp_max: get_lvl_xp(level),
    xp: remaining,
    percent: (remaining * 100.0 / get_lvl_xp(level)).round(2)
  )
end
