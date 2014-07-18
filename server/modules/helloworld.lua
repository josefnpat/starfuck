local helloworld = {}

function helloworld:getTrigger()
  return "!hello"
end

function helloworld:onHook(irc,user,channel,message,argv)
  return "Hello "..user.nick.."!"
end

return helloworld
