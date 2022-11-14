--core
ctx=0
CTX_TITLE=0
CTX_GAMEPLAY=1
CTX_GAMEOVER=2
CTX_SCORECARD=3
CTX_OPTIONS=4

function _init()
 ctx=CTX_TITLE

 --title svg
 set_svgcenter()
 refresh(0,0,0)

 --start visualizer
 start(0)
 file={
  data=ls() or {}, index=1,
  music_id=00, menu=false
}

arg=split(stat(6))

  --play theme music
  music(0)
end

function _update60()
 timer()

 --title volume visualizer
 update_visualizer()

 --animate svg title
 anim()
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
 
 current_track=title_track
end

function _draw()
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

function beep(f,v,l)
	for i=1,l do
		poke(-1,128+cos(i*f)*v)
		serial(0x808,-1,1)
	end
end