local reload = {}

function reload:getTrigger()
  return "!reload"
end

function reload:onHook(irc,user,channel,message,argv)
  reload_modules()
  local mod_names = {}
  for i,v in pairs(global_modules) do
    table.insert(mod_names,i)
  end
  return "Modules reloaded ("..table.concat(mod_names," ")..")"
end

return reload
