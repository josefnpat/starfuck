local module = {}

function module:getTrigger()
  return "!roll"
end

function module:onHook(irc,user,channel,message,argv)
  local sides = tonumber(argv[2])
  if sides == nil or sides < 1 or sides > 9999 then
    return "Usage: "..self:getTrigger().." [1..9999]"
  else
    return "You roll a "..math.random(1,sides)
  end
end

return module
