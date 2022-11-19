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
over=300 --used as gameover countdown
function timer()
 tick-=1
 over-=1
 if tick < 0 then
  blink= (not blink)
  tick=15
 end

 --test gameover using timer untile 
 --loss condition complete then
 --remove this code 
 if over == 1 then
  svg=svg_gameover
  ctx=CTX_GAMEOVER
  stopsvg=false
  set_svgcenter()
  refresh(0,0,0)
  current_track=title_track
  music(0)
  start()
 end
end

--Drawing Contexts

function gameover()
  local countdown = {10,9,8,7,6,5,4,3,2,1}
  init_easing()
  local done = flr(abs(over)/100)
  if(done==0) done = 1
  if(countdown[done]==nil) ctx=CTX_SCORECARD
  print("continue?",-30,6,12)
  print(countdown[done],20,6,8)
end

function scorecard()
 cls(3)
end

function playgame()
 cls(0)
 --map()
 print('yuh bruh',20,20,8)
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