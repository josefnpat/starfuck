require("socket")
require("lfs")

require("irc/init")

global_botname = "josefnpat|bot"
global_channel = "#asswb"
global_server = "irc.freenode.net"

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

function reload_modules()
  global_modules = {}
  for file in lfs.dir("modules") do
    if lfs.attributes(file,"mode") ~= "directory" and
        string.sub(file,1,1) ~= "." then
      local mod_name = string.gsub(file, '\.lua$','')
      local compiled_mod = assert(loadfile("modules/"..file))
      local mod = compiled_mod()
      global_modules[mod:getTrigger()] = mod
    end
  end
end

reload_modules()

local s = irc.new{nick = global_botname}
s:hook("OnChat", function(user, channel, message)
  local argv = explode(" ",message)
  if argv[1] and global_modules[argv[1]] then
    local ret = global_modules[argv[1]]:onHook(s,user,channel,message,argv)
    if type(ret) == "string" then
      if channel == global_botname then
        s:sendChat(user.nick,ret)
      else
        s:sendChat(global_channel,ret)
      end
    end
  end
end)
s:connect(global_server)
s:join(global_channel)

while true do
  s:think()
  socket.sleep(0.5)
end
