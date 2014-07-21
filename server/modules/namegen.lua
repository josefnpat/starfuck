-- Adapted from a script by VividReality

local module = {}

function module:getTrigger()
  return "!name"
end

module.vowel = {"a","e","o","u","i"}
module.vowel2 = {"a","e","o","u","i","ä","ö","å","ó","é","y"}
module.nonvowel = {"b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","z"}
module.NounDictionary = {"claw","paw","sword","spear","hammer","blade","fist","mouth","face","jaw","tail"}
module.MightAdjectiveDictionary = {"fierce","strong","fast","mighty","long","hard","power","swift"}
module.DarkAdjectiveDictionary = {"grim","dark","damned","blood","doom","grey","black","haunted","force","spirit","ghost"}
module.OrganicNounDictionary = {"firn","bloom","flower","plant","grass","leaf","oak"}
module.OrganicAdjectiveDictionary = {"green","fertile","blossom","pink","dream","fresh"}
module.syllableStart = {"lau","ar","wi","mo","sa","ta","ro","jo","a","mi","bla","au"}
module.syllableMid = {"ni","man","ma","no","na","o","a","nae","se","ma","pi","ke","ek","ra"}
module.syllableEnd = {"ra","jan","ld","lem","rs","ca","qa","tha","ta","ten","st","ph","da","th","ke","ir"}
module.hoodStart = {"Sha","Nay","Qui","She'","Na", "Dir'","Ta", "Queen ", "Tay", "Mar'", "Jaq", "Af"}
module.hoodMid = {"ni","qui","ma", "tan", "shan", "nay", "ta", "que", "mo", "ri"}
module.hoodEnd = {"ra","ti","'mo","ly", "'da", "ca", "qua", "que", "day", "ny"}
module.AsuraStart = {"Co","In","Dex","Dir","Eu","Ex","Cal"}
module.AsuraMid = {"dex","telli","tel","ter","re","de","cel","cu"}
module.AsuraEnd = {"dex","gence","lect","ter","ka","nce","ge","cior","ior","late"}

module.randomNameTemplates = {
  {2,1,3,2,1},
  {2,1,2,1,2},
  {2,1,2,1},
  {2,1,2,3,1},
  {1,2,2,1,2},
  {1,2,1,3,2},
  {1,2,1,2,3,2,2,1},
  {2,1,1,3,2},
}

module.patterns = {
  default = function(self)
    local template = self.randomNameTemplates[math.random(#self.randomNameTemplates)]
    local name = ""
    for i, letter_type in pairs(template) do
      if letter_type == 1 then
        name = name .. self.vowel[math.random(#self.vowel)]
      elseif letter_type == 2 then
        name = name .. self.vowel2[math.random(#self.vowel2)]
      else --if letter_type == 3 then
        name = name .. self.nonvowel[math.random(#self.nonvowel)]
      end
    end
    return name
  end,
  char = function(self)
    return self.MightAdjectiveDictionary[math.random(#self.MightAdjectiveDictionary)] ..
      self.NounDictionary[math.random(#self.NounDictionary)]
  end,
  necro = function(self)
    return self.DarkAdjectiveDictionary[math.random(#self.DarkAdjectiveDictionary)] ..
      self.NounDictionary[math.random(#self.NounDictionary)]
  end,
  sylvari = function(self)
    return self.OrganicAdjectiveDictionary[math.random(#self.OrganicAdjectiveDictionary)] ..
      self.OrganicNounDictionary[math.random(#self.OrganicNounDictionary)]
  end,
  necrosylvari = function(self)
    return self.DarkAdjectiveDictionary[math.random(#self.DarkAdjectiveDictionary)] ..
      self.OrganicNounDictionary[math.random(#self.OrganicNounDictionary)]
  end,
  syllable = function(self)
    return self.syllableStart[math.random(#self.syllableStart)] ..
      self.syllableMid[math.random(#self.syllableMid)] ..
      self.syllableEnd[math.random(#self.syllableEnd)]
  end,
  hood = function(self)
    return self.hoodStart[math.random(#self.hoodStart)] ..
      self.hoodMid[math.random(#self.hoodMid)] ..
      self.hoodEnd[math.random(#self.hoodEnd)]
  end,
  asura = function(self)
    return self.AsuraStart[math.random(#self.AsuraStart)] ..
      self.AsuraMid[math.random(#self.AsuraMid)] ..
      self.AsuraEnd[math.random(#self.AsuraEnd)]
  end,
}

function module:onHook(irc,user,channel,message,argv)
  if argv[2] and self.patterns[argv[2]] then
    pattern = argv[2]
  else
    local opts = {}
    for i,v in pairs(self.patterns) do
      table.insert(opts,i)
    end
    return "Usage: "..self:getTrigger().." ["..table.concat(opts,"|").."]"
  end
  local genf = self.patterns[pattern]
  return genf(self)
end

return module
