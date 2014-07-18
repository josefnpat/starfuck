local reload = {}

function reload:getTrigger()
  return "!reload"
end

function reload:onHook(irc,user,channel,message,argv)
  reload_modules()
  return "Modules reloaded."
end

return reload
