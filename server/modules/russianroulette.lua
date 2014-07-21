local module = {}

function module:getTrigger()
  return "!lucky"
end

function module:onHook(irc,user,channel,message,argv)
  if not self._chambers then
    self._chambers = {}
    self._chambers[math.random(1,6)] = true
    self._current = 1
  end
  if self._chambers[self._current] then
    self._chambers = nil
    return user.nick..": *Bang*"
  else
    self._current = self._current + 1
    return user.nick..": *Click*"
  end
end

return module
