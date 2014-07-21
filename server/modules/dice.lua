local module = {}

function module:getTrigger()
  return "!roll"
end

function module:onHook(irc,user,channel,message,argv)
  local sides = tonumber(argv[2]) and tonumber(argv[2]) or 6
  return "You roll a "..math.random(1,sides)
end

return module
