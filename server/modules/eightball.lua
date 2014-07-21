local eightball = {}

eightball.responses = {
  "It is certain.",
  "It is decidedly so.",
  "Without a doubt.",
  "Yes definitely.",
  "You may rely on it.",
  "As I see it, yes.",
  "Most likely.",
  "Outlook good.",
  "Yes.",
  "Signs point to yes.",
  "Reply hazy try again.",
  "Ask again later.",
  "Better not tell you now.",
  "Cannot predict now.",
  "Concentrate and ask again.",
  "Don't count on it.",
  "My reply is no.",
  "My sources say no.",
  "Outlook not so good.",
  "Very doubtful.",
}

function eightball:getTrigger()
  return "!8ball"
end

function eightball:onHook(irc,user,channel,message,argv)
  if argv[2] then
    return self.responses[math.random(1,#self.responses)]
  else
    return "Please ask a yes or no question."
  end
end

return eightball
