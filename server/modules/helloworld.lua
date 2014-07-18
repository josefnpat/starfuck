local reload = {}

function reload:getTrigger()
  return "!hello"
end

function reload:onHook(irc,user,channel,message,argv)
  return "Hello "..user.nick.."!"
end

return reload
