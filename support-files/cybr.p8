pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--core
--by p8-head (c) 2022
svg={
{10,34,20,30,21,21,25,15,27,10,29,8,29,7,29,6,30,6,29,6,30,5,30,5,30,6,30,7,31,9,31,14,32,20,32,30,31,35,31,39,30,40,30,40,30,41,29,41,30,40,32,38,34,33,39,31,41,29,43,29,43,30,43,31,42,32,41,33,40,35,40,36,39,39,37,42,34,47,30,49,27,51,25,51,25,50,25,50,25,49,25,47,25,46,26,44,27,43,27,42,27,42,26,42,25,42,25,42,24,42,24,41,24,40,25,40,26,40,26,40,27,40,28,39,28,39,28,39,28,38,28,37,28,37,27,36,27,36,28,33,28,31,28,26,28,26,27,26,26,31,23,34,22,37,21,38,21,39,21,40,21,41,21,41,20,42,20,42,20,41,19,41,19,40,18,39,18,39,18,39,18,34,20},
{10,61,18,58,21,51,27,49,30,46,34,47,35,50,34,53,33,57,31,58,30,60,29,59,31,59,31,59,32,60,33,62,33,64,33,68,32,69,32,71,31,72,30,70,30,69,30,66,30,65,30,64,30,64,30,65,29,67,29,69,29,71,29,72,28,72,27,72,27,71,27,68,27,68,27,67,27,68,27,69,27,70,27,70,26,71,26,72,26,73,26,73,28,73,29,72,32,71,33,71,35,72,36,73,35,74,35,75,33,78,32,80,32,85,33,87,34,90,34,91,33,91,33,91,33,91,32,95,31,100,30,108,29,112,27,116,26,116,25,113,24,110,23,103,23,100,24,96,25,95,27,94,29,92,30,91,31,91,31,90,31,90,31,89,31,88,31,86,30,86,29,87,29,90,28,92,27,93,26,92,26,90,25,87,25,81,24,79,24,76,24,76,24,74,25,72,25,68,25,66,25,64,25,64,26,63,26,63,26,63,25,62,25,61,25,59,25,59,24,59,23,61,21,62,20,63,19,63,18,63,17,64,17,64,16,65,15,65,15,65,15,65,15,65,14,65,14,61,18},
{10,109,28,108,30,107,32,107,33,107,34,108,35,110,34,112,34,115,33,117,31,118,30,118,29,116,29,115,29,113,31,112,31,111,31,111,31,112,30,113,30,115,29,116,28,116,27,116,26,116,26,116,26,115,26,115,26,115,26,115,25,116,25,117,24,118,24,119,23,120,23,120,22,119,22,117,21,114,22,112,23,111,24,110,26,109,28},
{10,129,23,127,24,122,27,120,29,118,31,118,32,121,33,123,34,127,34,129,35,131,35,131,34,131,34,131,34,132,34,133,34,133,33,134,32,138,32,142,33,148,36,151,37,154,38,154,37,152,36,151,35,148,33,146,32,144,31,144,31,143,30,143,29,141,29,143,28,144,27,148,25,151,24,153,23,154,22,154,21,155,21,155,21,152,22,149,23,143,25,140,25,138,26,138,25,138,24,138,24,136,24,135,25,133,27,132,30,129,31,127,32,125,31,125,30,126,28,129,25,130,24,132,22,132,22,132,22,131,21,131,21,129,23}
}


--level of details
lod=8

--camera position x,y and zoom z
camx=-64
camy=-64
camz=0.2

--coordinates of the svg center
svgcenter={x,y}





show_title=false
isgameover=false
function _init()
 inithackers()
 initplayer()
 initblock()
 initsignal()
 inittimer()
 
 blocks={}
  
 spk8_pitch,
 spk8_rate,
 spk8_volume,
 spk8_quality,
 spk8_intonation,
 spk8_if0,spk8_shift,
 spk8_bandwidth,
 spk8_whisper=
 140,1,1,.5,10,10,1,1,1

 
 show_title=title
 
 set_svgcenter()
 --refresh(0,0,0)
end

function _update60()
 local x=2
 --if (btn(⬅️)) x=2
 --if (btn(➡️)) x=-2
 local y=2
 --if (btn(⬆️)) y=2
 --if (btn(⬇️)) y=-2
 local z=.02
 --if (btn(🅾️)) z=-.02
 --if (btn(❎)) z=.02
 if (x!=0 or y!=0 or z!=0) refresh(x,y,z)
 
 if(player.deck < 1) gameover() return
 
 if not show_title then
 speako8()  
 uptimer()
 moveblock()
 
 if btn(❎) and btnp(⬅️) then
  if(player.cmd > 1) player.cmd -= 1
 elseif btn(❎) and btnp(➡️) then
  if(player.cmd < #cmds) player.cmd += 1
 else 
  if(btnp(⬅️)) cur(⬅️) 
  if(btnp(➡️)) cur(➡️) 
  if(btnp(⬆️)) cur(⬆️) 
  if(btnp(⬇️)) cur(⬇️) 
  if btnp(4) then
   player.issue = player.cmd
   docmd(player.issue)
   sfx(1,1)
  end
 end

 upsignal()
 else
  if btn(❎) then 
   show_title=false
   playing=false

   current_track=puzzle_track1
   play()
  elseif btnp(🅾️) then
  
   gameover()
  end
  -- why is this in update?
  --was also in draw
  --title()
  ezt+=1
  local st=6
	 if ezt<=ezd then
		
			ty=easing(ezt,ezby,ezcy,ezd,st)
		
	 else
		
	 end
 end
end

function _draw ()

 local cx=player.⬇️
 local cy=player.➡️
 
 
 
  if not show_title then
  cls()
  map()
 
 printhud()
 origintargets()
 
 draw_hacker(1,hacker1)
 draw_hacker(2,hacker2)
 draw_hacker(3,hacker3)
 
 if player.issue > 0 then
    --print(cmds[player.issue],(1*8) + 2,(14*8)+2)
 end
 
 --displayblocks()
 spr(block.tile,block.x * 8,block.y * 8)
 
 --paint cursors
 pntcursors(cx,cy)
 
 --highlight cursor target
 hlttrgt(cx,cy)

 printselctor()
 
 --executor line
 upexecutor()
 
 if(signal.on) drawsignal()
 else
 title()
 end
end

function uptimer()
 if timer.t < 0 then
  timer.t = 30
  upsignal()
 
 end
 
 signal.col += 1
 timer.t += 1
end


function gameover()
 if(isgameover) return
   music(-1)
   sfx(gameover_sfx)
   isgameover=true
end

--easing
 ezcy=-100
 ezby=100
 ezd=60
 ezt=0
 --title y
 ty=60


function title()
cls()
 refresh(0,0,0)
 --rectfill(0,0,128,96,0)
 rectfill(0,96+ty,128,110+ty,10)
 
 --cyberpunk
 --rectfill(0,60-ty,128,70-ty,10)
 for i=1,#svg do
  parse_bezier(svg[i])
 end
  
 print("boot system...",18,102+ty,0)
 
 spr(32,0,88+ty,2,1,false,false)
 
 pal(8,0)
 spr(34,70,96+ty,1,1,false,false)
 spr(35,78,88+ty,1,1,false,false)
 spr(48,96,96+ty,4,1,false,false)
 spr(52,6,100+ty,1,1,false,false)
 pal()
 
 play()
end

playing=false
title_track=0
puzzle_track1=13
gameover_sfx=19
current_track=title_track
function play()
 if not playing then
  music(current_track)
  playing=true
 end
end


function refresh(x,y,z)
 cls()
 camx+=x
 camy+=y
 camz+=z
 --camera(-60,-50,.2)
 for i=1,#svg do
  parse_bezier(svg[i])
 end
end

function find_pathborders(path)
 local x1=10000
 local y1=10000
 local x2=-10000
 local y2=-10000
 for i=2,#path-2,6 do
  x1=min(x1,path[i])
  y1=min(y1,path[i+1])
  x2=max(x2,path[i])
  y2=max(y2,path[i+1])
 end
 return {x1,y1,x2,y2}
end

--draw svg path per path
function parse_bezier(path)
 for i=2,#path-2,6 do
  local p1={path[i],path[i+1]}
  local p2={path[i+2],path[i+3]}
  local p3={path[i+4],path[i+5]}
  local p4={path[i+6],path[i+7]}
  local c=path[1]
  local bez_3=courbe_bezier_3({p1,p2,p3,p4},lod+camz)
  draw_lines(bez_3,c)
 end
end

--expand box if point doesn't fit inside
--need box={x1,y1,x2,y2}
--and x,y coordinates of the point
function expandbox(box,x,y)
 box.x1=min(box.x1,x)
 box.y1=min(box.y1,y)
 box.x2=max(box.x2,x)
 box.y2=max(box.y2,y)
 return box
end

--set the center of the whole svg
function set_svgcenter()
 local svgbox={x1=10000,y1=10000,x2=-10000,y2=-10000}
 --find borders of each path of the svg
 for i=1,#svg do
  local box=find_pathborders(svg[i])
  svgbox=expandbox(svgbox,box[1],box[2])
  svgbox=expandbox(svgbox,box[3],box[4])
 end
 svgcenter.x=(svgbox.x1+svgbox.x2)/2
 svgcenter.y=(svgbox.y1+svgbox.y2)/2
end



--thanks http://www.f-legrand.fr/scidoc/docmml/graphie/geometrie/bezier/bezier.html
--courbe de bezier cubique, calcul direct

function combinaison_lineaire(a,b,u,v)
 return {a[1]*u+b[1]*v,a[2]*u+b[2]*v}
end

function interpolation_lineaire(a,b,t)
 return combinaison_lineaire(a,b,t,1-t)
end

function point_bezier_3(points_control,t)
 local x=(1-t)^2
 local y=t*t
 local a=combinaison_lineaire(points_control[1],points_control[2],(1-t)*x,3*t*x)
 local b=combinaison_lineaire(points_control[3],points_control[4],3*y*(1-t),y*t)
 return {a[1]+b[1],a[2]+b[2]}
end

function courbe_bezier_3(points_control,n)
 local dt=1/n
 local t=dt
 local points_courbe={points_control[1]}
 while t<1 do
  add(points_courbe,point_bezier_3(points_control,t))
  t+=dt
 end
 add(points_courbe,points_control[4])
 return points_courbe
end

function draw_lines(points_courbe,c)
 for i=1,#points_courbe-1 do
  local p1=points_courbe[i]
  local p2=points_courbe[i+1]
  local p1x=camz*(p1[1]-svgcenter.x)
  local p1y=camz*(p1[2]-svgcenter.y)
  local p2x=camz*(p2[1]-svgcenter.x)
  local p2y=camz*(p2[2]-svgcenter.y)
  --only draw visible lines
  if (p1x>camx and p1x<camx+128 and p1y>camy and p1y<camy+128)
  or (p2x>camx and p2x<camx+128 and p2y>camy and p2y<camy+128)
  then
   line(p1x,p1y,p2x,p2y,c)
  end
 end
end








-->8
--blocks


function checkspot(destx,desty)
 local tle = mget(destx,desty)
 return fget(tle,0) or destx < 2 or desty > 14
end

function moveblock()
 local destx = block.x - 1
 local desty = block.y + 1

 if block.timer > block.speed then
  if block.y == block.line then
   if not checkspot(destx,block.line) then
    block.x = destx
   else
    --block done
    --blocks[#blocks+1]=block

    block.done = true
    
   end
  else
   block.y+=1
   
   if block.line == block.top then
    block.line = 0
   end
  end
  block.timer = 0
 else
  block.timer+=1
 end
 
  if block.done then
   local tile = flr(rnd(32)) + 64
   local lin = block.line
   
   if block.x > maxblox then
    lin -= 1
    newline()
   end
   
   mset(block.x,block.y,block.tile)
   initblock()
   block.tile = tile
   block.line = lin
  end
end


function newline()
 initsignal()
 togglesig()
end
-->8
--signal


function upsignal()
 if signal.on == true then
  movesig(signal.x,signal.y,signal.dir)
 end
end

function drawsignal()
 if signal.y < 25 then
  dmg()
 end
 
 circ(signal.x,signal.y,3,8)
 pset( signal.x, signal.y, signal.col)
end

function dmg()
 player.deck -=1
 signal.on = false
 sfx(2,1)
 say("_/-1.15/f/-1.25/r/-1.35/3/eh/-1.11/n/-1.73/_/d/-1.24/z/_/-1.36/r/-1.48/3/ow/-1.02/m/-1.65/ah/-1.13/n/-1.24/z/_/-1.70/_/k/-1.19/3/ah/-1.21/n/-1.74/_/t/-1.25/r/-1.67/iy/-1.02/m/-1.67/ih/-1.14/n/_/-1.20/l/-1.31/3/eh/-1.11/n/-1.72/_/d/-1.04/m/-1.25/iy/y/-1.26/ao/-1.09/r/1.28/-3/ih/1.57/-3/r/1.09/-3/z")
end

function togglesig()
 if signal.on == false then
  signal.on = true
 elseif signal.on == true then
  signal.on = false
 end
end

function dumbsign()

end


--x,y are where we are
--dir is where we wanna go
--will go dir if can, otherwise
--lateral but never back
function movesig(x,y,dir)
  player.msg = block.line
  --try dir
  if dir==1 then
  --left
   tryleft(x,y)
  elseif dir==2 then
  --right
   tryright(x,y)
  elseif dir==3 then
  --bottom
   trydown(x,y)
  elseif dir==4 then
  --top
   tryup(x,y)
  end
  
  --local px = pget(x,y)
  
end

function trydown(x,y)
 if pget(x,y+1) == 0 then
  signal.y += 1
 elseif pget(x-1,y) == 0 then
  signal.x -= 1
 elseif pget(x+1,y) == 0 then
  signal.x += 1
 end
end

function tryup(x,y)
 if pget(x,y-1) == 0 then
  signal.y -= 1
 elseif pget(x-1,y) == 0 then
  signal.x -= 1
 elseif pget(x+1,y) == 0 then
  signal.x += 1
 end
end

function tryright(x,y)
 if pget(x+1,y) == 0 then
  signal.x += 1
 elseif pget(x,y-1) == 0 then
  signal.y-=1
 elseif pget(x,y+1) == 0 then
  signal.y+=1
 end
end

function tryleft(x,y)
 if pget(x-1,y) == 0 then
  signal.x -= 1
 elseif pget(x,y-1) == 0 then
  signal.y-=1
 elseif pget(x,y+1) == 0 then
  signal.y+=1
 end
end
-->8
--commands
function docmd(cmd)
 local tle = mget(player.➡️,player.⬇️)
 player.msg = "cmd: "..cmd
 if cmd == 1 then
   snd()
 elseif cmd==2 then
   drp()
 elseif cmd==3 then
   swp(tle)
 elseif cmd==4 then
   flp(tle)
 elseif cmd==5 then
   mir(tle)
 elseif cmd==6 then
   rot(tle)
 end
end


function rot(tle)
 
end

function swp(tle)
 tle = flr(rnd(32))+64
 mset(player.⬇️,player.➡️,tle)
end

function mir(tle)
 --spr(64,player.➡️ * 8, player.⬇️ * 8,1,1,true,true)

 player.msg = "mirror "..tle.." "..player.➡️..","..player.⬇️
end

function flp(tle)
 spr(tle,player.➡️, player.⬇️,1,1,false,true)
end

function drp()

end

function snd()

end
-->8
--gui


function cur(bt)
 if bt == ⬅️ then
  if (player.⬇️ > 2) player.⬇️-=1
 elseif bt == ➡️ then
  if (player.⬇️ < 14) player.⬇️+=1
 elseif bt == ⬆️ then
  if (player.➡️ > 4) player.➡️-=1
 elseif bt == ⬇️ then
  if (player.➡️ < 14) player.➡️ += 1
 end
 
 sfx(0,1)
end

function pntcursors(cx,cy)
 spr(3,0,cy * 8)
 spr(4,cx * 8,3 * 8)
end

function printselctor()
 print("⬅️ "..cmds[player.cmd].." ➡️",50,12)
 
 local h = ""
 for i=0,player.hacks do
  h = h.."█"
 end
 
 print(h,50,18)
end

function hlttrgt(cx,cy)
 local tle = mget(cx,cy)
  if tle ~= 1 then
  pal(7,12,0)
  spr(tle, cx * 8,cy * 8)
  pal()
 end
end

function origintargets()
 mset(6,3,5)
 mset(11,9,5)
 mset(1,9,5)
 mset(6,15,5)
end


blue=12
green=11
red=8
grey=5
white=7
function printhat(col, x, y)
 pal(7,col,0)
 spr(27,x * 8,y * 8)
 pal()
end

function printhud ()
 mset(0,0,44)
 mset(1,0,45)
 mset(2,0,45)
 mset(3,0,45)
 mset(4,0,45)
 mset(5,0,46)
 mset(0,1,28)
 mset(1,1,29)
 mset(2,1,29)
 mset(3,1,29)
 mset(4,1,29)
 mset(5,1,30)
 mset(0,2,60)
 mset(1,2,61)
 mset(2,2,61)
 mset(3,2,61)
 mset(4,2,61)
 mset(5,2,62)
 
 print('deck '..player.deck,6,6,11)
 print('crypto '..player.crypto,6,12,11)
end

-->8
--init

function inithackers()
 hacker1=create_hacker()
 hacker2=create_hacker()
 hacker3=create_hacker()
end

function inittimer()
 timer={}
 timer.t = 0
end

function initplayer()
 player={}
 player.deck = 1
 player.crypto = 0
 player.cmd=1
 player.issue=0
 player.➡️ = 14
 player.⬇️ = 2
 player.hacks = 4
 player.msg = "████"
 initcmds()
end

--send: send new signal
--drop: if hit signal it dies
--swap: rot13 the tile
--flip: horizonally
--mir: mirror vertically
function initcmds()
 cmds={"send","drop","swap", "flip", "mir", "rot", "lock","split","inv","exec"}
end

function initblock()
 maxblox = 9
 block={}
 block.x=10
 block.y=4
 block.timer=0
 block.tile=64
 block.speed=1
 block.max=95
 block.top=4
 block.line=15
end

function initsignal()
 signal={}
 signal.x = 30
 signal.y = 30
 signal.col = 8
 signal.on = false
 signal.dir = 0
 
 local linecnt = block.line
 
 --start @ random side
 local sid = flr(rnd(4)) + 1
 --start @ random point
 if sid == 1 then
 --left
  signal.dir = 2
  signal.x = 30
  signal.y = flr(rnd(linecnt * 8)) 
 elseif sid == 2 then
 --right
  signal.dir = 1
  signal.x = 13 * 8
  signal.y = flr(rnd(linecnt * 8)) 
 elseif sid == 3 then
 --bottom
  signal.dir = 4
  signal.x = flr(rnd(linecnt * 8)) 
  signal.y = 14 * 8
 elseif sid == 4 then
 --top
  signal.dir = 3
  signal.x = flr(rnd(linecnt * 8)) 
  signal.y = 30 
 end
end
-->8
--executor
function upexecutor()
 --sfx(1,1)
  -- executor line
  --local yst = 32
  --for y=yst,127-yst do
  --  pset( 8, y, 13)
  --end
end
-->8
--speako8_lib_min by bikibird
do d=split("aa=1320,1,500,4,2,0,1,2600,160,1220,70,700,130,-250,100;ae=1270,1,1000,4,2,0,.79,2430,320,1660,150,620,170,-250,100;ah=770,1,1000,4,2,0,.79,2550,140,1220,50,620,80,-250,100;ao=1320,1,1000,4,2,0,.74,2570,80,990,100,600,90,-250,100;aw=720,1,1000,4,2,0,.79,2550,140,1230,70,640,80,-250,100/720,1,1000,4,3,0,0,2350,80,940,70,420,80,-250,100;ay=690,1,1000,4,2,0,.9,2550,200,1200,70,660,100,-250,100/690,1,1000,4,2,0,.223,2550,200,1880,100,400,70,-250,100;eh=830,1,1000,4,2,0,.44,2520,200,1720,100,480,70,-250,100;er=990,1,1000,4,2,0,.41,1540,110,1270,60,470,100,-250,100;ey=520,1,500,4,2,0,.44,2520,200,1720,100,480,70,-250,100/520,1,500,4,2,0,.05,2600,200,2020,100,330,50,-250,100;ih=720,1,1000,4,2,0,.23,2570,140,1800,100,400,50,-250,100;iy=880,1,1000,4,2,0,0,2960,400,2020,100,310,70,-250,100;ow=1210,1,1000,4,2,0,.59,2300,70,1100,70,540,80,-250,100;oy=513,1,1000,4,2,0,.62,2400,130,960,50,550,60,-250,100/513,1,1000,4,2,0,.13,2400,130,1820,50,360,80,-250,100/513,1,1000,4,2,0,.13,2400,130,1820,50,360,80,-250,100;uh=880,1,1000,4,2,0,.36,2350,80,1100,100,450,80,-250,100;uw=390,1,1000,4,2,0,.1,2200,140,1250,110,350,70,-250,100/390,1,1000,0,1,0,-.12,2200,140,900,110,320,70,-250,100/390,1,1000,0,0,0,-.12,2200,140,900,110,320,70,-250,100;l=440,1,1000,0,2,0,0,2880,280,1050,100,310,50,-250,100;r=440,1,1000,0,2,0,0,1380,120,1060,100,310,70,-250,100;m=390,1,1000,0,0,0,0,2150,200,1100,150,400,300,-450,100;n=360,1,1000,0,0,0,0,2600,170,1600,100,200,60,-450,100;ng=440,1,1000,0,0,0,0,2850,280,1990,150,200,60,-450,100;ch=230,0,20,0,0,1,0,2820,300,1800,90,350,200,-250,100/100,0,100,1,0,1,0,2820,300,1800,90,350,200,-250,100;sh=690,0,20,0,0,1,0,2750,300,1840,100,300,200,-250,100;zh=1,1,250,0,0,.5,0,2750,300,1840,100,300,200,-250,100/385,1,400,1,0,.5,0,2750,300,1840,100,300,200,-250,100;jh=330,1,500,1,0,1,0,2820,270,1800,80,260,60,-250,100;dh=275,1,250,0,0,.5,0,2540,170,1290,80,270,60,-250,100;f=1,0,15,0,0,1,0,2080,150,1100,120,340,200,-250,100/660,0,25,1,0,1,0,2080,150,1100,120,340,200,-250,100;s=690,0,10,0,0,1,0,2530,200,1390,80,320,200,-250,100;k=88,0,100,0,0,1,0,2850,330,1900,160,300,250,-250,100/220,2,5,1,0,1,0,2850,330,1900,160,300,250,-250,100;p=44,0,50,0,0,1,0,2150,220,1100,150,400,300,-250,100/220,2,2,1,0,1,0,2150,220,1100,150,400,300,-250,100;t=66,0,100,0,0,2,0,2600,250,1600,120,400,300,-250,100/220,2,5,0,0,1,0,2600,250,1600,120,400,300,-250,100;g=88,0,100,0,0,1,0,2850,280,1990,150,200,60,-250,100;b=44,0,100,0,1,0,0,2150,220,1100,150,400,300,-250,100;d=66,0,100,0,0,1,0,2600,170,1600,100,200,60,-250,100;th=606,0,10,0,0,1,0,2540,200,1290,90,320,200,-250,100;v=330,1,1000,0,0,.5,0,2080,120,1100,90,220,60,-250,100;z=410,1,1000,0,0,.5,0,2530,180,1390,60,240,70,-250,100;w=440,1,1000,0,0,0,.1,2150,60,610,80,290,50,-250,100;y=440,1,1000,0,0,0,0,3020,500,2070,250,260,40,-250,100;",";")x={}for a in all(d)do local e=split(a,"=")local d,a=e[1],split(e[2],"/")x[d]={}for e in all(a)do local a=split(e)local e={unpack(a,1,7)}e[8]={}for x=8,14,2do add(e[8],{unpack(a,x,x+1)})end add(x[d],e)end end poke(24374,@24374^^32)local C,y,D,g,z,E,d,r,n,b,m,F,s,u,j,G,H,I,o,f,l=unpack(split"0,0,0,0,0,0,0,0,0,0,0x8000,0x1.233b,-0x.52d4")local c,w,i,h,J,K,k,t,p,v,q,A,B={}e=split"2,0x1.fd17,0x1.fa32,0x1.f752,0x1.f475,0x1.f19d,0x1.eec9,0x1.ebfa,0x1.e92e,0x1.e666,0x1.e3a3,0x1.e0e3,0x1.de27,0x1.db70,0x1.d8bc,0x1.d60c,0x1.d360,0x1.d0b9,0x1.ce14,0x1.cb74,0x1.c8d8,0x1.c63f,0x1.c3aa,0x1.c119,0x1.be8c,0x1.bc02,0x1.b97c,0x1.b6fa,0x1.b47b,0x1.b200,0x1.af89,0x1.ad15,0x1.aaa5,0x1.a838,0x1.a5cf,0x1.a369,0x1.a107,0x1.9ea9,0x1.9c4d,0x1.99f6,0x1.97a1,0x1.9550,0x1.9302,0x1.90b8,0x1.8e71,0x1.8c2e,0x1.89ed,0x1.87b0,0x1.8576,0x1.8340,0x1.810c,0x1.7edc,0x1.7caf,0x1.7a85,0x1.785f,0x1.763b,0x1.741b,0x1.71fd,0x1.6fe3,0x1.6dcc,0x1.6bb8,0x1.69a7,0x1.6798,0x1.658d,0x1.6385,0x1.6180,0x1.5f7e,0x1.5d7e,0x1.5b82,0x1.5988,0x1.5792,0x1.559e,0x1.53ad,0x1.51bf,0x1.4fd3,0x1.4deb,0x1.4c05,0x1.4a22,0x1.4842,0x1.4664,0x1.4489,0x1.42b1,0x1.40dc,0x1.3f09,0x1.3d39,0x1.3b6b,0x1.39a0,0x1.37d8,0x1.3612,0x1.344f,0x1.328f,0x1.30d1,0x1.2f15,0x1.2d5c,0x1.2ba6,0x1.29f2,0x1.2841,0x1.2692,0x1.24e5,0x1.233b,0x1.2193,0x1.1fee,0x1.1e4b,0x1.1cab,0x1.1b0c,0x1.1971,0x1.17d7,0x1.1640,0x1.14ab,0x1.1319,0x1.1189,0x1.0ffb,0x1.0e6f,0x1.0ce5,0x1.0b5e,0x1.09d9,0x1.0857,0x1.06d6,0x1.0558,0x1.03db,0x1.0261,0x1.00e9,0x.ff74,0x.fe00,0x.fc8f,0x.fb1f,0x.f9b2,0x.f847,0x.f6dd,0x.f576,0x.f411,0x.f2ae,0x.f14d,0x.efee,0x.ee91,0x.ed36,0x.ebdd,0x.ea86,0x.e930,0x.e7dd,0x.e68c,0x.e53c,0x.e3ef,0x.e2a3,0x.e15a,0x.e012,0x.decc,0x.dd88,0x.dc45,0x.db05,0x.d9c6,0x.d889,0x.d74e,0x.d615,0x.d4de,0x.d3a8,0x.d274,0x.d142,0x.d012,0x.cee3,0x.cdb6,0x.cc8b,0x.cb61,0x.ca39,0x.c913,0x.c7ee,0x.c6cc,0x.c5aa,0x.c48b,0x.c36d,0x.c251,0x.c136,0x.c01d,0x.bf05,0x.bdef,0x.bcdb,0x.bbc8,0x.bab7,0x.b9a7,0x.b899,0x.b78d,0x.b682,0x.b578,0x.b470,0x.b36a,0x.b265,0x.b161,0x.b05f,0x.af5f,0x.ae5f,0x.ad62,0x.ac66,0x.ab6b,0x.aa71,0x.a979,0x.a883,0x.a78e,0x.a69a,0x.a5a8,0x.a4b7,0x.a3c7,0x.a2d9,0x.a1ec,0x.a100,0x.a016,0x.9f2d,0x.9e45,0x.9d5f,0x.9c7a,0x.9b97,0x.9ab4,0x.99d3,0x.98f3,0x.9815,0x.9738,0x.965c,0x.9581,0x.94a7,0x.93cf,0x.92f8,0x.9222,0x.914e,0x.907a,0x.8fa8,0x.8ed7,0x.8e07,0x.8d39,0x.8c6b,0x.8b9f,0x.8ad4,0x.8a0a,0x.8941,0x.8879,0x.87b3,0x.86ed,0x.8629,0x.8566,0x.84a4,0x.83e3,0x.8323,0x.8264,0x.81a7,0x.80ea,0x.802e,0x.7f74,0x.7eba,0x.7e02,0x.7d4b,0x.7c94,0x.7bdf,0x.7b2b,0x.7a78,0x.79c6,0x.7915,0x.7864,0x.77b5,0x.7707,0x.765a,0x.75ae,0x.7503,0x.7458,0x.73af,0x.7307,0x.725f,0x.71b9,0x.7114,0x.706f,0x.6fcb,0x.6f29,0x.6e87,0x.6de6,0x.6d46,0x.6ca7,0x.6c09,0x.6b6c,0x.6ad0,0x.6a35"a=split"1,0x.fd19,0x.fa3a,0x.f764,0x.f497,0x.f1d1,0x.ef13,0x.ec5e,0x.e9b0,0x.e70a,0x.e46c,0x.e1d5,0x.df46,0x.dcbe,0x.da3d,0x.d7c4,0x.d552,0x.d2e7,0x.d083,0x.ce26,0x.cbd0,0x.c981,0x.c738,0x.c4f6,0x.c2bb,0x.c086,0x.be57,0x.bc2f,0x.ba0d,0x.b7f1,0x.b5dc,0x.b3cc,0x.b1c2,0x.afbf,0x.adc1,0x.abc9,0x.a9d6,0x.a7e9,0x.a602,0x.a421,0x.a244,0x.a06e,0x.9e9c,0x.9cd0,0x.9b09,0x.9947,0x.978a,0x.95d3,0x.9420,0x.9272,0x.90c9,0x.8f25,0x.8d86,0x.8beb,0x.8a55,0x.88c4,0x.8737,0x.85af,0x.842b,0x.82ac,0x.8130,0x.7fba,0x.7e47,0x.7cd9,0x.7b6e,0x.7a08,0x.78a6,0x.7748,0x.75ee,0x.7498,0x.7346,0x.71f7,0x.70ad,0x.6f66,0x.6e22,0x.6ce3,0x.6ba7,0x.6a6f,0x.693a,0x.6809,0x.66db,0x.65b0,0x.6489,0x.6366,0x.6245,0x.6128,0x.600e,0x.5ef7,0x.5de4,0x.5cd3,0x.5bc6,0x.5abc,0x.59b5,0x.58b0,0x.57af,0x.56b1,0x.55b5,0x.54bc,0x.53c7,0x.52d4,0x.51e3,0x.50f6,0x.500b,0x.4f22,0x.4e3d,0x.4d5a,0x.4c79,0x.4b9c,0x.4ac0,0x.49e7,0x.4911,0x.483d,0x.476b,0x.469c,0x.45cf,0x.4505,0x.443c,0x.4376,0x.42b3,0x.41f1,0x.4132,0x.4075,0x.3fba,0x.3f01,0x.3e4a,0x.3d95,0x.3ce3,0x.3c32,0x.3b83,0x.3ad7,0x.3a2c,0x.3983,0x.38dc,0x.3837,0x.3794,0x.36f3,0x.3653,0x.35b6,0x.351a,0x.3480,0x.33e8,0x.3351,0x.32bc,0x.3229,0x.3197,0x.3107,0x.3079,0x.2fed,0x.2f62,0x.2ed8,0x.2e50,0x.2dca,0x.2d45,0x.2cc2,0x.2c40,0x.2bbf,0x.2b40,0x.2ac3,0x.2a47,0x.29cc,0x.2953,0x.28db,0x.2864,0x.27ef,0x.277b,0x.2709,0x.2698,0x.2628,0x.25b9,0x.254b,0x.24df,0x.2474,0x.240a,0x.23a2,0x.233b,0x.22d4,0x.226f,0x.220b,0x.21a9,0x.2147,0x.20e6,0x.2087,0x.2029,0x.1fcb,0x.1f6f,0x.1f14,0x.1eba,0x.1e60,0x.1e08,0x.1db1,0x.1d5b,0x.1d06,0x.1cb2,0x.1c5e,0x.1c0c,0x.1bbb,0x.1b6a,0x.1b1b,0x.1acc,0x.1a7e,0x.1a31,0x.19e5,0x.199a,0x.1950,0x.1907,0x.18be,0x.1876,0x.182f,0x.17e9,0x.17a4,0x.175f,0x.171b,0x.16d8,0x.1696,0x.df50,0x.1614,0x.15d3,0x.1594,0x.1556,0x.1518,0x.14da,0x.149e,0x.cbd9,0x.1427,0x.13ec,0x.13b3,0x.137a,0x.1341,0x.1309,0x.12d2,0x.ba15,0x.1265,0x.1230,0x.11fb,0x.11c7,0x.1193,0x.1160,0x.112e,0x.a9de,0x.10cb,0x.109a,0x.106a,0x.103a,0x.100b,0x.0fdd,0x.0faf,0x.9b10,0x.0f54,0x.0f28,0x.0efc,0x.0ed0,0x.0ea5,0x.0e7b,0x.0e51,0x.8d8c,0x.0dfe,0x.0dd6,0x.0dad,0x.0d86,0x.0d5e,0x.0d38,0x.0d11,0x.8136,0x.0cc6,0x.0ca1,0x.0c7c,0x.0c58,0x.0c34,0x.0c11,0x.0bee,0x.0bcb,0x.0ba9,0x.0b87,0x.0b66,0x.0b45,0x.0b24,0x.0b03"function say(e)local p=split(e,"/")local d,e,a,n,t,f,m,j,r,v={},{}local s,b,u,w,y,g=unpack(split"1,1,0,0,0,0")for z in all(p)do local p=tonum(z)if p then local a=abs(p)local e,d,x=sgn(p),a\1,a&.99999
    if(d==1)b=1+e*x
    if(d==2)s=1+e*x
    if d==3then u=e
    if(x>0)u*=x
    end elseif z=="hh"then g=b*440elseif z=="_"then add(c,{1100*b*spk8_rate})else for p in all(x[z])do f,o,m,j,r,i,h,k=unpack(p)a,n,t,v,d,w,e,y={},{},{},f*b,e,y,k,m l=u*spk8_intonation+h*spk8_if0
    if(j==0)w=m
    if(r==0or#d~=#e)d=k
    for c=1,#d do add(a,{unpack(d[c])})local x,d=a[c],e[c]local e,a=r*(d[1]-x[1]),r*(d[2]-x[2])x.x,x.e,x.d=0,0,0if c<4then e*=spk8_shift a*=spk8_bandwidth end add(n,e/f)add(t,a/f)end if g>0then add(c,{g,2,0,1,0,1,h,a,n,t,e,s,l})g=0end add(c,{v,o,i,w,j*(y-w)/f,y,h,a,n,t,e,s,l})end s,b,u=1,1,0end end end function speaking()return#c>0end function mute()c={}b=0end function speako8()local function x()f=(5512.5/(spk8_pitch+l)+(f and f*49or 0))/(f and 50or 1)end if#c>0then w=c[1]while stat(108)<1920do for k=0,127do if w then if b<1then b,o,i,u,j,G,h,J,H,I,K,B,l=unpack(w)b/=spk8_rate end if o then x()t,d,p=spk8_quality*f,u/8,o*spk8_whisper if p==1then if n%flr(f+.5)==0then r,q,n=-d/(f-1),-d/t/t,0v=-q*t/3x()end if n>t then r=-d/(f-1)else v+=q r-=v end d=r elseif p>1then d=-8for x=1,16do d+=rnd()end
    if(n>f\2)d/=2
    end for n,x in pairs(J)do local b,c,f,o=x[1],x[2]\10+1c=c<=#e and c or#e c=c>=1and c or 1A=cos(b/5512.5)if b>0then f,o=e[c]*A,-a[c]x.d,x.e,x.x=x.e,x.x x.x=(1-f-o)*d+f*x.e+o*x.d d=x.x elseif b<0then f=F*A local x=1-f-s C=(d-f*y-s*D)/x D,y,f=y,d,F*cos(.04897)g=(1-f-s)*C+f*z+s*E E,z=z,g d=g end local e=K[n]
    if(b\10~=e[1]\10)x[1]+=H[n]
    if(c-1~=e[2]\10)x[2]+=I[n]
    end d*=i/2-1+rnd(i)
    if(abs(u-G)>abs(j))u+=j
    else d,B=0,1end n+=1b-=1poke(m+k,d*spk8_volume*B+128)if b<1then deli(c,1)if#c==0then serial(2056,m,k+1)return else w=c[1]end end end end serial(2056,m,128)end end end end

--end of speako8_lib_min
-->8
-- name generator


names_phonemes = {
{ s = 'da', m = 'n', e = 'se' }, 
{ s = 'jer', m = '', e = 'rik' }, 
{ s = 'as', m = 'i', e = 'mov' }, 
{ s = 'vik', m = '', e = 'tor' }, 
{ s = 'de', m = 'exe', e = 'ter' }, 
{ s = 'ro', m = 'y', e = 'ce' }, 
{ s = 'no', m = 'o', e = '' }, 
{ s = 'trin', m = 'it', e = 'y' }, 
{ s = 'clu', m = '', e = 'tch' }, 
{ s = 'cog', m = 'lio', e = 'stro' }, 
{ s = 'arm', m = 'i', e = 'tage' }, 
{ s = 'bi', m = 'shop', e = '' }, 
{ s = 'gun', m = '', e = 'nar' }, 
{ s = 'harv', m = '', e = '' }, 
{ s = 'lu', m = '', e = 'kas' }, 
{ s = 're', m = '', e = 'zin' }, 
{ s = 'ge', m = 'nea', e = 'va' }, 
{ s = 'mis', m = '', e = 'ty' }, 
{ s = 're', m = '', e = 'zin' },
{ s = 'ev', m = 'e', e = 'lyn' },
{ s = 'ist', m = '', e = 'zla' },
{ s = 'il', m = '', e = 'sa' },
{ s = 'max', m = '', e = 'ine' },
{ s = 'do', m = '', e = 'ra' },
{ s = 'yu', m = '', e = 'ki' },
{ s = 'ma', m = '', e = 'ko' },
{ s = 'aer', m = '', e = 'is' },
{ s = 'deck', m = '', e = 'er' },
{ s = 'dr', m = '', e = 'edd' },
{ s = 'au', m = 'ro', e = 'ra' },
{ s = 'gos', m = 'sym', e = 'er' },
{ s = 'a', m = '', e = 'va' },
{ s = 'sa', m = 'bine', e = '' },
{ s = 'alt', m = '', e = '' },
{ s = 'mael', m = '', e = 'strom' },
{ s = 'stark', m = '', e = '' },
{ s = 'mav', m = 'er', e = 'ik' },
{ s = 'cryp', m = '', e = 'to' },
{ s = 'un', m = 'es', e = 'cape' },
{ s = 'to', m = '', e = 'ken' },
{ s = 'jer', m = 'ich', e = 'o' },
{ s = 'lo', m = 'rek', e = '' },
{ s = 'lo', m = '', e = 'rez' },
{ s = 'ga', m = '', e = 'spar' },
{ s = 'nau', m = 'ti', e = 'lus' },
{ s = 'ne', m = '', e = 'mo' },
{ s = 'ag', m = 'a', e = 'tha' },
{ s = 'bri', m = '', e = 'ar' },
{ s = 'er', m = '', e = 'lys' },
{ s = 'es', m = 'trel', e = 'la' },
{ s = 'u', m = 'mek', e = 'ki' },
{ s = 'scar', m = '', e = 'let' },
{ s = 'si', m = '', e = 'byl' },
{ s = 'o', m = 'ka', e = 'mi' }}


function get_rnd_name()
 return  rnd(names_phonemes)["s"]..rnd(names_phonemes)["m"]..rnd(names_phonemes)["e"]
end
-->8
--hackers

hackers={}
function create_hacker()
 local hacker={}
 hacker.hat=rnd(hats)
 hacker.col=0
 hacker.name=get_rnd_name()
 hacker.hash=""
 hacker.bits={}
 hacker.deck=255
 hacker.armor=4
 hacker.stole=true
 hacker.d_hat=false
 hacker.d_name=false
 add(hackers,hacker)
 
 local bin=hash(hacker.name)
 local cnt=1
 for b in all(bin) do
  hacker.hash=hacker.hash.." "..encode(b)
  if(cnt==1) hacker.col=b
  if(cnt < 16) add(hacker.bits,(b%2)==0)
  cnt+=1
 end
 
  --first char
 --col=ord(code)
 
 return hacker
end

function draw_hacker(position,hacker)
 local y_off=0
 
 if(position==1) y_off=0
 if(position==2) y_off=42
 if(position==3) y_off=84
 
 --print((hacker.hash), 34,70+y_off,8)
 print(hacker.name, 93,27+y_off,8)
 
 printhat(hacker.hat,(93),0+y_off)
 spr(18,93,8+y_off)
 if(hacker.stole) spr(7,93,20+y_off)
 draw_identicon(hacker.col,hacker.bits,111,1+y_off)

end

blue=12  --vengeful noob
green=11 --noob
red=8    --vigilante
grey=6   --unethical
white=7  --ethical
black=5  --malicious
hats={white,black,grey,blue,red,green}
function printhat(col, x, y)
 pal(7,col,0)
 spr(17,x,y)
 pal()
end


-->8
--hash functions

function hash(input)
 local str=""
 local arr={}
 local ttl=0
 
 for i=1,#input do
 local c = sub(input,i,i+1)
  local d=ord(c)
  local b=dtb_8(d)
  ttl+=1
  add(arr,b)
 end
 
 local pad_arr=pad(arr)
 local arr2=cat(arr,pad_arr)
 local tkc=#input
 local tkb=dtb_8(tkc)
 add(arr2,tkb)
 
 return arr2
end

--pad with zeroes
function pad(arr)
 local len = #arr*8
 local padding=(448-1-len)
 local zeroes="00000000"
 local result ={}

 for cnt=0, padding,8 do
   add(result,zeroes) 
 end

 return result
end

--decimal to bin 8
function dtb_8(num)
  local bin=""
  for i=7,0,-1do
    bin..=num\2^i %2
  end
  return bin
end

--decimal to bin 16
function dtb_16(num)
 local bin=""
 for i=1,16 do
  bin=num %2\1 ..bin
  num>>>=1
 end
 return bin
end

--concatenate tables
function cat(a1,a2)
 local arr=a1
 
 for el in all(a2) do
  add(arr,el)
 end
 
 return arr
end

function encode(bits)
  local code = bits
  msg=bits
  if bits=="0001" then
   code= "a"
  elseif bits=="0011" then
   code= "b"  
  elseif bits=="0111" then
   code= "c" 
  elseif bits=="1111" then
   code= "d" 
  elseif bits=="1110" then
   code= "e" 
  elseif bits=="1100" then
   code= "f" 
  elseif bits=="1000" then
   code= "g" 
  elseif bits=="0010" then
   code= "h" 
  elseif bits=="0100" then
   code= "i" 
  elseif bits=="1001" then
   code= "j"     
  else  
   code = flr(rnd(10))
  end
 
  return code
end
-->8
--identicon

function printbits(bits)
 local bit=""
 for b in all(bits) do
 local t=""
 if b==true then
  t="t"
 else
 t="f"
 end
  bit=bit..t
 end
 msg=bit
end

function draw_identicon(col,bits,x1,y1)
 printbits(bits)
 
 local sz=3
 rect(x1-2,y1-2,x1+22,y1+22,7)
 
 local i=0
 for w=1, 5 do
 if(bits[w+(i*3)])   rectfill(x1+0*sz,y1+(w*sz),(x1+0*sz)+sz,y1+(w*sz)+sz,col)
 if(bits[w+1+(i*3)]) rectfill(x1+1*sz,y1+(w*sz),(x1+1*sz)+sz,y1+(w*sz)+sz,col)
 if(bits[w+2+(i*3)]) rectfill(x1+2*sz,y1+(w*sz),(x1+2*sz)+sz,y1+(w*sz)+sz,col)
 if(bits[w+1+(i*3)]) rectfill(x1+3*sz,y1+(w*sz),(x1+3*sz)+sz,y1+(w*sz)+sz,col)
 if(bits[w+(i*3)])   rectfill(x1+4*sz,y1+(w*sz),(x1+4*sz)+sz,y1+(w*sz)+sz,col)
 
 end
 --local xoff=(1+sz)
 --if(bits[1]) rectfill(x1+(1+sz)*0,y1,x1+((1+sz)*1)-1,y1+sz,col)
 --if(bits[2]) rectfill(x1+(1+sz)*1,y1,x1+((1+sz)*2)-1,y1+sz,col)
 --if(bits[3]) rectfill(x1+(1+sz)*2,y1,x1+((1+sz)*3)-1,y1+sz,col)
 --if(bits[2]) rectfill(x1+(1+sz)*3,y1,x1+((1+sz)*4)-1,y1+sz,col)
 --if(bits[1]) rectfill(x1+(1+sz)*4,y1,x1+((1+sz)*5)-1,y1+sz,col)

 --if(bits[4]) rectfill(x1,y1+5,x1+sz,y1+9,col)
 --if(bits[5]) rectfill(x1+5,y1+5,x1+9,y1+9,col)
 --if(bits[6]) rectfill(x1+10,y1+5,x1+14,y1+9,col)
 --if(bits[5]) rectfill(x1+15,y1+5,x1+19,y1+9,col)
 --if(bits[4]) rectfill(x1+20,y1+5,x1+24,y1+9,col)

 --if(bits[7]) rectfill(x1,y1+10,x1+sz,y1+14,col)
 --if(bits[8]) rectfill(x1+5,y1+10,x1+9,y1+14,col)
 --if(bits[9]) rectfill(x1+10,y1+10,x1+14,y1+14,col)
 --if(bits[8]) rectfill(x1+15,y1+10,x1+19,y1+14,col)
 --if(bits[7]) rectfill(x1+20,y1+10,x1+24,y1+14,col)

 --if(bits[10]) rectfill(x1,y1+15,x1+sz,y1+19,col)
 --if(bits[11]) rectfill(x1+5,y1+15,x1+9,y1+19,col)
 --if(bits[12]) rectfill(x1+10,y1+15,x1+14,y1+19,col)
 --if(bits[11]) rectfill(x1+15,y1+15,x1+19,y1+19,col)
 --if(bits[10]) rectfill(x1+20,y1+15,x1+24,y1+19,col)

 --if(bits[13]) rectfill(x1,y1+20,x1+sz,y1+24,col)
 --if(bits[14]) rectfill(x1+5,y1+20,x1+9,y1+24,col)
 --if(bits[15]) rectfill(x1+10,y1+20,x1+14,y1+24,col)
 --if(bits[14]) rectfill(x1+15,y1+20,x1+19,y1+24,col)
 --if(bits[13]) rectfill(x1+20,y1+20,x1+24,y1+24,col)
end
-->8
--animation


function linear_easing(t,b,c,d)
	return c * t / d + b
end

function quad_easing(t,b,c,d)
	t /= d/2
	if (t < 1) return c/2*t*t + b
	t-=1
	return -c/2 * (t*(t-2) - 1) + b
end


--- easing functions


function easing(t,b,c,d,style)
	if style==0 then	
	 --linear easing
	 return c * t / d + b
 
 --======== quadratics =======
 elseif style==1 then
 	--quad ease in
 	t/=d
		return c*t*t + b
	elseif style==2 then
	 --quad ease out
	 t/=d
		return -c * t*(t-2) + b
	elseif style==3 then
		--quad easing in/out
		t/=d/2
 	if (t < 1) return c/2*t*t + b
 	t-=1
 	return -c/2 * (t*(t-2) - 1) + b
 
 --========== cubics =========
	elseif style==4 then
		--cubic ease in
	 t/=d
		return c*t*t*t + b
	elseif style==5 then
		--cubic ease out
	 t/=d
		t-=1
		return c*(t*t*t + 1) + b
	elseif style==6 then
		--cubic ease in/out
	 t/=d/2
 	if (t < 1) return c/2*t*t*t + b
 	t-=2
 	return c/2*(t*t*t + 2) + b
	
 --======== circular =========	
	elseif style==7 then
		--circular ease in
	 t/=d
		return -c * (sqrt(1 - t*t) - 1) + b
	elseif style==8 then
		--circular ease out
	 t/=d
		t-=1
		return c * sqrt(1 - t*t) + b
	elseif style==9 then
		--circular ease in/out
	 t /= d/2
 	if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b
 	t-=2
 	return c/2 * (sqrt(1 - t*t) + 1) + b

	--======== specials ========
	elseif style==10 then
		--bounce out
		t/=d
 	if t < (1/2.75) then
 		return c*(7.5625*t*t) + b
 	elseif (t < (2/2.75)) then
 		t-=(1.5/2.75)
 		return c*(7.5625*t*t + 0.75) + b
 	elseif (t < (2.5/2.75)) then
 	 t-=(2.25/2.75)
 		return c*(7.5625*t*t + 0.9375) + b
 	else 
 		t-=(2.625/2.75)
 		return c*(7.5625*t*t + 0.984375) + b
 	end
	elseif style==11 then
		--elastic out
		t/=d
		local ts = t * t
  local tc = ts*t
  return b+c*(33*tc*ts + -106*ts*ts + 126*tc + -67*ts + 15*t)
 elseif style==12 then
		--elastic in/out
		t/=d
		local ts = t * t
  local tc = ts*t
  if t<0.3 then
  	return b+c*(56*tc*ts + -105*ts*ts + 60*tc + -10*ts + 0*t)
  elseif t>0.7 then
	  return b+c*(56*tc*ts + -175*ts*ts + 200*tc + -100*ts + 20*t)
	 else
			lt=(t-0.3)/0.4	
			lc=0.98884*c		
			lb=b+lc*(0.00558)
	 	return lc * lt + lb
	 end
 --======== default =========	
	else
		--linear easing 
	 return c * t / d + b
	end
end





---


function linear_easing(t,b,c,d)
 return c * t / d + b
end

function quad_in(t,b,c,d)
 t /= d
	return c*t*t + b
end

function quad_out(t,b,c,d)
 t /= d
	return -c * t*(t-2) + b
end

function quad_in_out(t,b,c,d)
 t /= d/2
	if (t < 1) return c/2*t*t + b
	t-=1
	return -c/2 * (t*(t-2) - 1) + b
end

function cubic_in(t,b,c,d)
 t /= d
	return c*t*t*t + b
end

function cubic_out(t,b,c,d)
 t /= d
	t-=1
	return c*(t*t*t + 1) + b
end

function cubic_in_out(t,b,c,d)
 t /= d/2
	if (t < 1) return c/2*t*t*t + b
	t-=2
	return c/2*(t*t*t + 2) + b
end

function circular_in(t,b,c,d)
 t /= d
	return -c * (sqrt(1 - t*t) - 1) + b
end

function circular_out(t,b,c,d)
 t /= d
	t-=1
	return c * sqrt(1 - t*t) + b
end

function circular_in_out(t,b,c,d)
 t /= d/2
	if (t < 1) return -c/2 * (sqrt(1 - t*t) - 1) + b
	t-=2
	return c/2 * (sqrt(1 - t*t) + 1) + b
end

function bounce_out(t,b,c,d)
	--bounce out
	t/=d
	if t < (1/2.75) then
		return c*(7.5625*t*t) + b
	elseif (t < (2/2.75)) then
		t-=(1.5/2.75)
		return c*(7.5625*t*t + 0.75) + b
	elseif (t < (2.5/2.75)) then
	 t-=(2.25/2.75)
		return c*(7.5625*t*t + 0.9375) + b
	else 
		t-=(2.625/2.75)
		return c*(7.5625*t*t + 0.984375) + b
	end
end

function elastic_out(t,b,c,d)
	--elastic out
	t/=d
	local ts = t * t
 local tc = ts*t
 return b+c*(33*tc*ts + -106*ts*ts + 126*tc + -67*ts + 15*t)
end


function elastic_in_out(t,b,c,d)
	--elastic in/out
	t/=d
	local ts = t * t
 local tc = ts*t
 if t<0.3 then
 	return b+c*(56*tc*ts + -105*ts*ts + 60*tc + -10*ts + 0*t)
 elseif t>0.7 then
  return b+c*(56*tc*ts + -175*ts*ts + 200*tc + -100*ts + 20*t)
 else
		lt=(t-0.3)/0.4	
		lc=0.98884*c		
		lb=b+lc*(0.00558)
 	return lc * lt + lb
 end
end
__gfx__
00000000000000000000b00000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000bbbbb000bb000000000000000bb00000000000000000000000000000000000000000005555555500000000000000000000000000000000
007007000000000000b0000000bbb000bbbbbbbb00b00b0000000000000000000000000000000000000000005555555500000000000000000000000000000000
000770000000000000bbbbb000bbbb000bbbbbb00b0000b000000000000000000000000000000000000000005555555500000000000000000000000000000000
0007700000000000000000b000bbbb0000bbbb000b0000b000000000000000000000000000000000000000005555555500000000000000000000000000000000
007007000000000000bbbbb000bbb000000bb00000b00b0000000000000000000000000000000000000000005555555500000000000000000000000000000000
00000000000000000000b00000bb000000000000000bb00000000000000000000000000000000000000000005555555500000000000000000000000000000000
00000000000000000000000000b00000000000000000000000000000000000000000000000000000000000005555555500000000000000000000000000000000
000000000007700055555555555555555555555555555555555555550000000000000000000000000000000000000000c0000555000000000000000c00000000
00000000007777005333bbb5533300055000000550000005500000050000000000000000000000000000000000077000c0000555555555555550000c00000000
00000000007777005333bbb5533300055000000550000005500000050000000000000000000000000000000000777700c0050555555555555550000c00000000
00000000700000075333bbb5533300055000000550000005500000050000000000000000000000000000000000777700c0055555555555555550000c00000000
00000000077777705111ccc55111ccc55111ccc55000ccc5500000050000000000000000000000000000000070000007c0000555555555555550000c00000000
00000000000000000511cc500511cc500511cc500500cc50050000500000000000000000000000000000000007777770c0000555555555555555000c00000000
00000000000000000051c5000051c5000051c5000050c500005005000000000000000000000000000000000000000000c0000555555555555555550c00000000
000000000000000000055000000550000005500000055000000550000000000000000000000000000000000000000000c0000555005550000000050c00000000
0000000000000000aa88888a88888888000000000000000000000000000000002222202002222222ccc44444444ccccc000000000cc00000000000c000000000
0000000000000000aaa888aa88888888000000000000000000008000000000002222020200202222cc4447777774cccc00000000ccccc000cc000cc000000000
0000000000000000aaaa8aaa888888880000000000000000008888008000000022200007f0020022cc44777777774ccc000ccccccccccccc0ccccccc00000000
0000000000000000aaaaaaaa88888888000000000000000000888800800000002200700000070222cc47777777774ccc00cc0000000000000000000c00000000
0000000000000000aaaaaaaa8888888800000000000000000888888088000000200700ffff007022ccf7707777074ccc0cc00555555555555500000c00000000
0000000000a00000aaaaaaaa88888888000000000000000008888880888000002200000000000002cf77707777074ccc0c000555555555555000000c00000000
aaaaaaaaaaaa0000aaaaaaaa8aaa8888000000000000000008888888888800002000888008880022cf47777777774ccccc000555555555550050000c00000000
aaaaaaaaaaaaa000aaaaaaaaaaaaa8880000000000000000888800888888880028708880088807c2cc47774444475cccc0000555555555555550000c00000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa8888aa0000000008888008800000002c708880088807b27744f4fffff45777c0000555555555555550000c00000000
88aaaaa888aaaaa888aaaaa888aaaaa8a8cccc8a000000000088000888000080222f000ff000f222774444f445f54777c0005555555555555550000c00000000
8aaaaa888aaaaa888aaaaa888aaaaa888c7cccc800000000000000088800008822200ffffff00222775444f444f45777c0055555555555555550000c00000000
aaaaa888aaaaa888aaaaa888aaaaa8888ccccc18000000000000000888800008220000f44f0000227704444445457777c0005500000000000000000c00000000
aaaa888aaaaa888aaaaa888aaaaa888a8ccccc1800000000000000088880000822200000000002227774444454577777c0000000000000000000000c00000000
aaa888aaaaa888aaaaa888aaaaa888aa81ccc1180000000000000080088800882222000ff00022227777444545477777cc00000000cccc00000000cc00000000
aa888aaaaa888aaaaa888aaaaa888aaaa811118a000000000000008000888880222220000002222277777454547777770ccc00cccc000ccc000cccc000000000
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa8888aa00000000000000080000880022222200002222227777777777777777000ccc0000000000cccc000000000000
70007077777000777000777077707777707000070770777770000070000700007077777700070007777707077777770000007700000000070000000070007777
70707077000070007070007070000000707077770700000070777070077777777000000007070707700007000000000777707707707707070777707000700000
00707077077777770077707077077077707000000777777000707077770070077077777707770707007777770777777000707707707007070700007007707770
77777000007070007070000000070000707770707770000070707000707070707070000000070707070007000000007070700007707707070777777000000700
00707770707770770000770777777777707000707770777700707770700070007077077007077707000707700777777070777707707007070700000007077770
70707070700070707770700070070000707707770770000070700000707070777070007007000707077777700000700070007000707707070777777707070770
70707070777070770070007777070770707000000700777070777770707070070070707077777777000007000777777000770070700777070700000000000000
70000070777000077070707077077770707077770770070070007000007007077777707000070000770777070070000070700777770000070777777707777770
07700007700000007000000070707077777070000000000707077707070770070000000700000070700770700007070077777777777070707777000777777777
07707707707777707077777070700070000000700777770007077700070070777777770007777070007770770777077770000000000070770007077700000007
00707707707000000070007077707070777077770707070707077707777007700000077007007070777070007707070070777770777070007707070077777707
07707707707077777070707070707000700070000700077007000707700000707777007007077077000077777000070770700070007077770707077000000707
07000700707070007077707070707070777777077770770007000707007770700000077000070000777700007777070770707070707000000707007077770707
07070707707077070000007000707070000700000000000707777707077077707777770077770777000707770000000770700070707070770707077000070707
07070707707007077777777070007070707007777777770700000007070000000000000770070700770707007770777770770777707070770007070077070707
07077707707707077000000077700070000077770000070777777707070777777777777777070777070707070070700070000700777070707777077707070707
__gff__
0000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010101010101010101010101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101000000000000000101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010300280000000000246250000000000000000000000000246150000000000000000c30018625000000000018000180002430018000180001800024300180001800018000000000000000000000000000000000
010200280c31500000000000000000000000000f2250000000000000000c3000c415000000000000000000000c3000000000000000000c30000000000000741500000000000c2150000000000000000c30000000
010200280c31500000000000000000000000000f2250000000000000000c3000c415000000000000000000000c3000000000000000000c30000000000000741500000000000c2150000000000000000c30000000
010300280000000000246250000000000000000000000000246150000000000000000c30018625000000000018000180002430018000180001800024300180001800018000000000000000000000000000000000
010300280000000000246250000000000000000000000000246150000000000000000c30018625000000000018000180002430018000180001800024300180001800018000000000000000000000000000000000
011000010017000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d1100000000000000002146000210b11000141021200e01002140020200e11002040021200e010021400e010000000000002146000210b11000041021200e01002140020200e11002040021200e010021400e010
01100000000000000000140021201011005040021200e01000140021201011002040021200e000021400e000021000410000140021201011005040021200e01000140021201011002040021200e000021400e000
012000000db650db550db450db351075510745107351072500a5517b5517b4517b3517b2517b2510755107450db650db550db450db351075510745107351072500a5417b5517b4517b3517b2517b250db250db35
011d0c201072519b5519b4519b3519b251005510045100351002517b550f7350f7350f7250f72510725107251072519b3519b3519b2519b250b0250b0350b7350b0250b7250b72517b3517b350f7350f7350f725
0120000012b6512b5512b4512b351575515745157351572500a5510b5510b4510b3510b2510b25157551574512b6512b5512b4512b35157551574500a54157351572519b5519b4519b3519b2519b250db250db35
011d0c20107251eb351eb351eb351eb251503515035150251502517b35147351472514725147251572515725157251eb351eb351eb251eb2515025150351573515025157251572519b3519b350f7350f7350f725
0120000019b5519b450db3501b551405014040147321472223b3523b450bb350bb551505015040157321572219b5519b450db3501b551705019040197321972223b3523b450bb350bb551c0501e0401e7321e722
012000001eb551eb4512b3506b552105021040217322172228b4528b3528b2520050200521e0401e7321e7221eb551eb4512b3506b552105021040257322572228b5528b4528b3528b251c0401e0301e7221e722
d1100000000000000002146000210b11000141021200e01002140020200e11002040021200e010021400e010000000000002146000210b11000041021200e01002140020200e11002040021200e010021400e010
0110002005a4008a3009a200aa3009a4008a3006a2002a3001a4006a3006a2003a3002a4003a3005a2007a3008a4009a300aa200aa300aa4009a3008a2007a3005a4003a3002a2002a3002a4002a3004a2007a30
d110002016040160301602316011190411a0331a0101a0201d0401c0401c0331c0301c0201c0231d0201b0201a04019040190431903019030190331a0201a0201a0401a04319041190301a031190331902019023
01100000180501804018040180501c0701c0702307023070230702307023050230302103121030210302104024051240602407024070240702407024070240702807023070210701d06018050170401103010020
471000000f0520f052220521605212052120520c0520c052220522205212052120520f051160531e0531e0521e051200712007320073200702007025071250702503325033270312703022031220372203022030
01100000000000000000000180501804018040180501c0701c0702307023070230702307023050230302103121030210302104024051240602407024070240602406024050240502404024030240252400024000
01100000000000000000000000000000000000180501804018040180501c0701c0702307023070230702307021071210602106021050210502104021030210202102021015240002400000000000000000000000
111000000f0520f052220521605212052120520c0520c052220522205212052120520f051160531e0531e0521e051200712007320073200702007025071250702503025033270312703022031220372203022030
c51000000c1730c1732460024600246753c9000c8003c9000c1730c800000000c80024675000000c8000c8000c1730c173246750c80024675000000c8000c8000c1730c800000000c8000c100246752467524675
01100000000000000000140021201011005040021200e01000140021201011002040021200e000021400e000021000410000140021201011005040021200e01000140021201011002040021200e000021400e000
0118042000b260cb260cb2600b2600b2600b260cb260cb260cb2600b2600b260cb260cb260cb2600b2600b260cb2600b2600b2600b260cb260cb260cb2600b260cb2600b260cb260cb2600b260cb260cb2605b26
012000200ca200fa3010a4011a5010a400fa300da2009a3008a400da500da400aa3009a200aa300ca400ea500fa4010a3011a2011a3011a4010a500fa400ea300ca200aa3015a4015a5015a4015a300ba200ea30
012c002000000000000000000000000000000000000000001372413720137201372015724157201572015722137241872418720187201872018720187201872018725187021a7241c7211c7201c7201c7201c720
012800001c7201f7241f7201f7201f7201f720157241572015720157201572015720157201572215725000001c7241c7201c7201c7201c7201f7241f7201f7201f7201f722157241572015720157201572015720
012800001572015725000001f7241c7241c7201c7201c7201c7201c72215724137211372013720137201372013720137221872418720187201872018720187201872018720187201872218725187001870018705
012000000dd650dd550dd450dd351075510745107351072500c5517d5517d4517d3517d2517d2510755107450dd650dd550dd450dd351075510745107351072500c5417d5517d4517d3517d2517d250dd250dd35
011d0c201072519d5519d4519d3519d251005510045100351002517d550f7350f7350f7250f72510725107251072519d3519d3519d2519d250b0250b0350b7350b0250b7250b72517d3517d350f7350f7350f725
0120000012d6512d5512d4512d351575515745157351572500c5510d5510d4510d3510d2510d25157551574512d6512d5512d4512d35157551574500c54157351572519d5519d4519d3519d2519d250dd250dd35
011d0c20107251ed351ed351ed351ed251503515035150251502517d35147351472514725147251572515725157251ed351ed351ed251ed2515025150351573515025157251572519d3519d350f7350f7350f725
0120000019d5519d450dd3501d551405014040147321472223d3523d450bd350bd551505015040157321572219d5519d450dd3501d551705019040197321972223d3523d450bd350bd551c0501e0401e7321e722
012000001ed551ed4512d3506d552105021040217322172228d4528d3528d2520050200521e0401e7321e7221ed551ed4512d3506d552105021040257322572228d5528d4528d3528d251c0401e0301e7221e722
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 08404344
00 08424344
00 09424344
02 08424344
01 0a0b4344
00 0a0b4344
00 0c0d4344
00 0a0e4344
00 0a0e4344
02 0c0f4344
01 111a1b1c
00 111a1b1d
02 111a1b1e
01 1f204344
00 1f204344
00 21224344
00 1f234344
00 1f234344
02 21244344

