
DPP.set_area_limit = function (area,limit)
      if not G[area] then sendWarnMessage("Could not execute, area does not exist.") return end
      G[area].config.card_limit = limit or 5
end