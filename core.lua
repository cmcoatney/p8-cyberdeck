--core
ctx=0
CTX_TITLE=0
CTX_GAMEPLAY=1
CTX_GAMEOVER=2
CTX_SCORECARD=3
CTX_OPTIONS=4

function _init()
 ctx=CTX_TITLE
 set_svgcenter()
 refresh(0,0,0)
end

function _update60()
 timer()
 local x,y,x=0,0,0

 if camz < 2 and not stopsvg then 
  z=.02 
 else
  reverse=true
 end
 if reverse and not stopsvg then
  if camz>.8 then 
   z=-.02 
   else
   camz=.82
  end
 end
 
 if(camz < 0) stopsvg=true
 
 ezt+=1
 local st=6
	if ezt<=ezd then
		ty=easing(ezt,ezby,ezcy,ezd,st)
	end
 
 if(not stopsvg) refresh(x,y,z)
 
 
 if(svgglitch==true) glitch()
 current_track=title_track
end

function _draw()
 cls()

 --draw context
 if(ctx==CTX_TITLE) title() init_easing()
 if(ctx==CTX_GAMEPLAY) playgame()
 if(ctx==CTX_GAMEOVER) gameover()
 if(ctx==CTX_SCORECARD) scorecard()
 if(ctx==CTX_OPTIONS) options()


end

tick=15
function timer()
 tick-=1
 if tick < 0 then
  
  blink= (not blink)
  tick=15
 end
end

--Drawing Contexts
 

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


--utilities
function hcenter(s)
  -- screen center minus the
  -- string length times the 
  -- pixels in a char's width,
  -- cut in half
  return 64-#s*2
end
