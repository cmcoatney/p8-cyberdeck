--core

function _init()

end

function _update60()
 timer()
end

function _draw()
 cls()
 
 --draw context
 map()
end

tick=30
function timer()
 tick-=1
 if tick < 0 then
  --do something
  tick=30
 end
end