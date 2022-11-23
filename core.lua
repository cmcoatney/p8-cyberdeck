--core
ctx=0
CTX_TITLE=0
CTX_GAMEPLAY=1
CTX_GAMEOVER=2
CTX_SCORECARD=3
CTX_OPTIONS=4

player={}
function _init()
  player.points=0
  cartdata("p8-head_cyberdeck_1")
  --load_scores()

  ctx=CTX_SCORECARD

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

function savegame()
--highscore
if(dget(0)<player.points) dset(0,player.points)
end

function _update60()
 timer()
 if(ctx==CTX_GAMEOVER) check_continue()

 --title volume visualizer
 if(ctx==CTX_TITLE) update_visualizer()

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

 --test gameover using timer untill 
 --loss condition complete then
 --remove this code (this only occurs once)
 if over == 1 then
  --topten(scores)
  svg=svg_gameover
  ctx=ctx_gameover
  stopsvg=false
  set_svgcenter()
  refresh(0,0,0)
  current_track=title_track
  music(0)
  start()
 end
end

function do_gameover()

end

--Drawing Contexts

function gameover()
  local countdown = {10,9,8,7,6,5,4,3,2,1}
  init_easing()
  local done = flr(abs(over)/100)
  if(done==0) done = 1
  if(countdown[done]==nil) end_countdown() return
  print("continue?",-30,6,12)
  print(countdown[done],20,6,8)
  if(blink) print(call_to_action,hcenter(call_to_action)-64,20,12) 
end

high_score=500
low_score=50
function scorecard()
 camera()
 cls(0)
 print('highscores',hcenter('highscores'),4,8)
 
 local x=50
 local y = 14
 for g in all(nicks) do
  print(g,64-((#g)*4),y,7)
  y+=10
 end
 
 x+=66
 y=14
 for i=1, #highscores do
  local col=12
  if(highscores[i]>=high_score) col=10
  if(highscores[i]<=low_score) col=8
  print(highscores[i],66,y,col)
  y+=10
 end
 if(blink) print(call_to_action,hcenter(call_to_action),120,12)
end

function playgame()
 cls(0)
 --map()
 print('GAME ON',-30,6,12)
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