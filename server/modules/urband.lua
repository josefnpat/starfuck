local urband = {}

require('libs.json')

function urband:getTrigger()
  return "!urbanup"
end

function urband:onHook(irc,user,channel,message,argv)

  local http = require("socket.http")

  if argv[2] then
    local raw = http.request("http://api.urbandictionary.com/v0/define?term="..argv[2])
    local data = json.decode(raw)
    if data.result_type == "exact" then
      local result = data.list[1]
      return result.definition .." - "..result.permalink
    else
      return "No definition found."
    end
  else
    return "Usage: !urbanup [word]"
  end
end

return urband
