--core
ctx=0
CTX_TITLE=0
CTX_GAMEPLAY=1
CTX_GAMEOVER=2
CTX_SCORECARD=3
CTX_OPTIONS=4

function _init()
 ctx=CTX_TITLE
end

function _update60()
 timer()
end

function _draw()
 cls()
 
 --draw context
 if(ctx==CTX_TITLE) title()
 if(ctx==CTX_GAMEPLAY) playgame()
 if(ctx==CTX_GAMEOVER) gameover()
 if(ctx==CTX_SCORECARD) scorecard()
 if(ctx==CTX_OPTIONS) options()
end

tick=30
function timer()
 tick-=1
 if tick < 0 then
  --do something
  tick=30
 end
end

--Drawing Contexts
function title()
 cls(10)
end

function gameover()
 cls(8)
end

function scorecard()
 cls(7)
end

function playgame()
 map()
end

function options()
 cls(12)
end
