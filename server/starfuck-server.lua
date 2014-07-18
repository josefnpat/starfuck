require "irc/init"

global_botname = "josefnpat-bot"
global_channel = "#asswb"
global_server = "irc.freenode.net"

global_modules = { "eightball" }

modules = {}
for _,v in pairs(global_modules) do
  local mod = require("modules."..v)
  modules[mod:getTrigger()] = mod
end

function explode(div,str) -- credit: http://richard.warburton.it
  if (div=='') then return false end
  local pos,arr = 0,{}
  -- for each divider found
  for st,sp in function() return string.find(str,div,pos,true) end do
    table.insert(arr,string.sub(str,pos,st-1)) -- Attach chars left of current divider
    pos = sp + 1 -- Jump past current divider
  end
  table.insert(arr,string.sub(str,pos)) -- Attach chars right of last divider
  return arr
end

local sleep = require "socket".sleep
local s = irc.new{nick = global_botname}
s:hook("OnChat", function(user, channel, message)
  local argv = explode(" ",message)
  if argv[1] and modules[argv[1]] then
    local ret = modules[argv[1]]:onHook(s,user,channel,message,argv)
    if type(ret) == "string" then
      s:sendChat(global_channel,ret) 
    end
  end
end)
s:connect(global_server)
s:join(global_channel)

while true do
  s:think()
  sleep(0.5)
end
