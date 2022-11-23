pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--by p8-head (c) 2022

--#include cyberdeck/animations.lua
--core
ctx=0
ctx_title=0
ctx_gameplay=1
ctx_gameover=2
ctx_scorecard=3
ctx_options=4

player={}
function _init()
  player.points=0
  cartdata("p8-head_cyberdeck_1")
  load_scores()

  ctx=ctx_scorecard

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
 if(ctx==ctx_gameover) check_continue()

 --title volume visualizer
 if(ctx==ctx_title) update_visualizer()

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
 if(ctx==ctx_title) title() init_easing()
 if(ctx==ctx_gameplay) playgame()
 if(ctx==ctx_gameover) gameover()
 if(ctx==ctx_scorecard) scorecard()
 if(ctx==ctx_options) options()
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
  topten(scores)
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

--drawing contexts

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
 print('game on',-30,6,12)
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

-->8
--title screen

svgcol=7
animate=5
loading=0
function anim()
 animate-=1
 if animate<0 then
  loading+=1
  if(loading>3) loading=0
  animate=5
 end
end

title_y=64 
loading_cnt=0
cam_offset=64
blink=false
title_loaded=false
call_to_action="press ❎"
function title()
 draw_upper_panel()
 draw_lower_panel()

 local eez=0
 if (ezt<=ezd) eez=easing(ezt,ezby,ezcy,ezd,11)

 if(blink and eez==0) print(call_to_action,hcenter(call_to_action)-cam_offset,80+eez-cam_offset,12) title_loaded=true 
end

reverse=false
stopsvg=false
function refresh(x,y,z)
 cls()
 camx+=x
 camy+=y
 camz+=z

 camera(camx,camy)
 for i=1,#svg do
  parse_bezier(svg[i])
 end
end

function draw_upper_panel()
 rectfill(30-cam_offset,0-title_y-cam_offset,100-cam_offset,6-title_y-cam_offset,10)
 rectfill(0-cam_offset,14-title_y-cam_offset,127-cam_offset,20-title_y-cam_offset,10)
 line(0-cam_offset,18-title_y-cam_offset,127-cam_offset,18-title_y-cam_offset,0)

 rectfill(0-cam_offset,26-title_y-cam_offset,127-cam_offset,30-title_y-cam_offset,10)
 line(0-cam_offset,27-title_y-cam_offset,127-cam_offset,27-title_y-cam_offset,0)
 spr(48,0-cam_offset,31-title_y-cam_offset,1,1,false,true)
 spr(48,120-cam_offset,31-title_y-cam_offset,1,1,true,true)

 --blackout
 rectfill(23-cam_offset,7-title_y-cam_offset,106-cam_offset,17-title_y-cam_offset,0)
 rectfill(27-cam_offset,18-title_y-cam_offset,102-cam_offset,21-title_y-cam_offset,0)

 if(title_loaded) draw_volume_meter()
--blackout bottom of leftmost volume bar hangdown
line(0-cam_offset,25-cam_offset,29-cam_offset,25-cam_offset,0)
line(0-cam_offset,24-cam_offset,29-cam_offset,24-cam_offset,0)
    

--diagonal overlays
 line(23-cam_offset,13-title_y-cam_offset,29-cam_offset,0-title_y-cam_offset,10)
 line(23-cam_offset,14-title_y-cam_offset,29-cam_offset,1-title_y-cam_offset,10)
 line(23-cam_offset,16-title_y-cam_offset,29-cam_offset,3-title_y-cam_offset,10)
 line(23-cam_offset,17-title_y-cam_offset,29-cam_offset,5-title_y-cam_offset,10)

 line(100-cam_offset,0-title_y-cam_offset,106-cam_offset,13-title_y-cam_offset,10)
 line(100-cam_offset,1-title_y-cam_offset,106-cam_offset,14-title_y-cam_offset,10)
 line(100-cam_offset,3-title_y-cam_offset,106-cam_offset,16-title_y-cam_offset,10)
 line(100-cam_offset,6-title_y-cam_offset,106-cam_offset,17-title_y-cam_offset,10)

 line(27-cam_offset,21-title_y-cam_offset,31-cam_offset,25-title_y-cam_offset,10) 
 line(27-cam_offset,20-title_y-cam_offset,36-cam_offset,25-title_y-cam_offset,10) 
 line(27-cam_offset,21-title_y-cam_offset,35-cam_offset,25-title_y-cam_offset,10) 
 line(27-cam_offset,20-title_y-cam_offset,33-cam_offset,25-title_y-cam_offset,10) 
 line(27-cam_offset,20-title_y-cam_offset,32-cam_offset,25-title_y-cam_offset,10) 
 line(26-cam_offset,19-title_y-cam_offset,38-cam_offset,25-title_y-cam_offset,10) 

 line(102-cam_offset,20-title_y-cam_offset,89-cam_offset,26-title_y-cam_offset,10)
 line(103-cam_offset,20-title_y-cam_offset,98-cam_offset,25-title_y-cam_offset,10) 
 line(103-cam_offset,20-title_y-cam_offset,97-cam_offset,25-title_y-cam_offset,10) 
 line(103-cam_offset,21-title_y-cam_offset,95-cam_offset,25-title_y-cam_offset,10) 
 line(103-cam_offset,20-title_y-cam_offset,93-cam_offset,25-title_y-cam_offset,10) 
 line(103-cam_offset,21-title_y-cam_offset,99-cam_offset,25-title_y-cam_offset,10) 
end

function draw_lower_panel()
 spr(48,20-cam_offset,92+title_y-cam_offset,1,1,false,false)
 rectfill(0-cam_offset,92+title_y-cam_offset,20-cam_offset,100+title_y-cam_offset,10)
 spr(48,88-cam_offset,90+title_y-cam_offset,1,1,false,false)
 rectfill(84-cam_offset,90+title_y-cam_offset,88-cam_offset,100+title_y-cam_offset,10)
 spr(48,76-cam_offset,90+title_y-cam_offset,1,1,true,false)
 rectfill(0-cam_offset,96+title_y-cam_offset,127-cam_offset,120+title_y-cam_offset,10)
 pal(8,0)
 spr(49,70-cam_offset,96+title_y-cam_offset)
 pal()

 local subtitle="hackerz\nprofile"
 print(subtitle,35-cam_offset,104+title_y-cam_offset,0)

 draw_hazard_tape_pattern()
 draw_zero_one()
end

function draw_hazard_tape_pattern()
 local y_offset=98+title_y
 local x_offset=80

 for i=x_offset,x_offset+60,4 do
  line(i-cam_offset,y_offset-cam_offset,8+i-cam_offset,y_offset+8-cam_offset,0)
  line(i-cam_offset,y_offset+1-cam_offset,8+i-cam_offset,y_offset+8+1-cam_offset,0)
 end
 --trim around stripes for cleaner look
 rectfill(80-cam_offset,106+title_y-cam_offset,127-cam_offset,108+title_y-cam_offset,10)
 rectfill(80-cam_offset,98+title_y-cam_offset,127-cam_offset,100+title_y-cam_offset,10)
 rectfill(81-cam_offset,98+title_y-cam_offset,85-cam_offset,108+title_y-cam_offset,10)
end

function draw_zero_one()
 --vertical
 rectfill(4-cam_offset,100+title_y-cam_offset,6-cam_offset,118+title_y-cam_offset,0)
 rectfill(10-cam_offset,100+title_y-cam_offset,12-cam_offset,118+title_y-cam_offset,0)

 rectfill(18-cam_offset,100+title_y-cam_offset,20-cam_offset,118+title_y-cam_offset,0)

 --horizontal
 rectfill(4-cam_offset,100+title_y-cam_offset,12-cam_offset,102+title_y-cam_offset,0)
 rectfill(4-cam_offset,116+title_y-cam_offset,12-cam_offset,118+title_y-cam_offset,0)
 rectfill(16-cam_offset,116+title_y-cam_offset,22-cam_offset,118+title_y-cam_offset,0)
 rectfill(16-cam_offset,100+title_y-cam_offset,20-cam_offset,102+title_y-cam_offset,0)
end

function draw_volume_bar(x,y,height) 
    --draw blue volume bar
    line(x-cam_offset,y-cam_offset,x-cam_offset,y-cam_offset-height,12)
end

volumes={}
function get_volumes()
    for v=1, 36 do
        local spike=spike(v) + rnd(4)
        if(spike < 0 or music_events.volume[1]==0) spike = 0
        if(spike >18) spike = 16
        volumes[v]= spike
    end
end

function spike(n)
   if(n%6==0) return music_events.volume[1]
   if(n%5==0) return music_events.pitch[1]+1
   if(n%4==0) return music_events.notevol[1] * rnd(8)
   if(n%3==0) return (music_events.effect[1]) * rnd(6)
   return (music_events.wave[1]+8)
end

function draw_volume_meter()
   local num=1
   get_volumes()

   for i=29, 99, 2 do
    --draw_volume_bar(i,25,18)
    draw_volume_bar(i,25,volumes[num])
    num+=1
   end
end

--svg

svg_title={
    {7,76,43,76,43,74,41,74,41,74,41,60,51,60,51,60,51,73,52,73,52,73,52,73,50,73,50},
    {7,78,45,78,45,80,50,80,50,80,50,82,51,82,51,82,51,88,46,88,46,88,46,90,46,90,46,90,46,72,70,72,70},
    {7,105,30,105,30,90,50,90,50,90,50,91,51,91,51,91,51,105,44,105,44,105,44,105,42,105,42,105,42,99,42,99,42},
    {7,119,43,119,43,109,43,109,43,109,43,104,50,104,50,104,50,105,51,105,51,105,51,113,50,113,50},
    {7,109,46,109,46,116,46,116,46},
    {7,113,61,113,61,122,43,122,43,122,43,131,43,131,43,131,43,132,45,132,45,132,45,121,49,121,49,121,49,121,51,121,51,121,51,132,56,132,56},
    {7,150,31,150,31,142,51,142,51,142,51,132,51,132,51,132,51,131,50,131,50,131,50,143,44,143,44},
    {7,160,43,160,43,149,43,149,43,149,43,145,50,145,50,145,50,146,51,146,51,146,51,154,50,154,50},
    {7,150,46,150,46,156,46,156,46},
    {7,173,43,173,43,171,40,171,40,171,40,157,51,157,51,157,51,170,51,170,51,170,51,170,49,170,49},
    {7,180,36,180,36,168,62,168,62},
    {7,188,39,188,39,179,44,179,44,179,44,178,46,178,46,178,46,195,56,195,56},
    }
svg=svg_title    
--level of details
lod=.01 --8 default

--camera position x,y and zoom z
camx=-64
camy=-64
camz=.01--0.6

--coordinates of the svg center
svgcenter={x,y}

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
  
  --glitchmode
   if(flr(rnd(100))==0)p1x-=flr(rnd(5))
   if(flr(rnd(100))==0)p1y-=flr(rnd(5))
   if(flr(rnd(100))==0)p2x-=flr(rnd(5))
   if(flr(rnd(100))==0)p2y-=flr(rnd(5))
   if flr(rnd(10))==0 then
    local f=flr(rnd(3))
    if(f==0) c = 10
    if(f==1) c = 12
    if(f==2) c = 8
   end
  --endglitch
   line(p1x,p1y,p2x,p2y,c)
  end
 end
end

-- visualizer
function reload_music(f)
	reload(0x3100,0x3100,4608,f)
end

function start(...)
	music(...)
	isnt_1st_frame=false
end


function update_visualizer()
	music_events:update()
	if btnp()&63>0 then
	 ctx=ctx_gameplay
	 stopsvg=true
	 music(-1,500)
	 cls(14)
	end
end


-- music events

music_events={
	wave={-8,-8,-8,-8},
	pitch={-1,-1,-1,-1},
	volume={0,0,0,0},
	notevol={0,0,0,0},
	effect={0,0,0,0},
	sfxinstr={},
	pattern={-1,-1,-1,-1},
	row={-1,-1,-1,-1},
	speed={0,0,0,0}
}
last=0
notestr={[0]="♪ c ",unpack(split"♪ c#,♪ d ,♪ d#,♪ e ,♪ f ,♪ f#,♪ g ,♪ g#,♪ a ,♪ a#,♪ b ")}
fxstr={[0]="",unpack(split" slide,vibrato,♪ drop,fade in, decay")}

function music_events:update()
	local t=t()
	local d=t-last
	last=t
	
	for i=1,4 do
		local m=128>>(@0x5f40>>i-1&1)
		
		if not self.sfxinstr[i] and self.effect[i]==3 or self.effect[i]==5 then
			local voldec=m*self.notevol[i]*d/self.speed[i]
			self.volume[i]=max(self.volume[i]-voldec)
		elseif self.effect[i] == 4 then
			local volinc=m*self.notevol[i]*d/self.speed[i]
			self.volume[i]=min(self.volume[i]+volinc,self.notevol[i])
		end
		
		self:update_c(i)
		
		if self.notevol[i]==0 or self.row[i]>31 then
			self.volume[i]=0
			self.wave[i]=-8
			self.pitch[i]=-1
			self.effect[i]=0
			self.sfxinstr[i]=false
		end
	end
end

function music_events:update_c(i)
	local speed,wave,pitch,volume,fx,sfxinstr=0,-8,-1,0,0,0
	local pattern=stat(45+i)
	local row=-1
	if pattern>=0 then
		row=stat(49+i)
		if (pattern==self.pattern[i] and row==self.row[i]) return
		local notedat=%(0x3200+pattern*68+2*row)
		speed=@(0x3241+pattern*68)
		wave=notedat>>6&7
		pitch=notedat&63
		volume=notedat>>9&7
		fx=notedat>>12&7
		sfxinstr=notedat<0
	end
	
	self.speed[i]=max(speed,1)
	self.wave[i]=wave
	self.pitch[i]=pitch
	self.volume[i]=fx==4 and 0 or volume
	self.notevol[i]=volume
	self.effect[i]=fx
	self.sfxinstr[i]=sfxinstr
	self.pattern[i]=pattern
	self.row[i]=row
end

function music_events:getfx(i)
	if (self.effect[i]==3 and self.sfxinstr[i]) return "retrig."
	if self.effect[i]==6 then
		return "arp  /"..(self.speed[i]<9 and 2 or 4)
	end
	if self.effect[i]==7 then
		return "arp  /"..(self.speed[i]<9 and 4 or 8)
	end
	return fxstr[self.effect[i]]
end

function music_events:getnote(i)
	if (self.pitch[i]==-1) return ""
	return notestr[self.pitch[i]%12]..self.pitch[i]\12
end

function music_events:getsfxinstr(i)
	if (self.wave[i]>=0) return "sfx "..self.wave[i]
end

function music_events:getpattern(i)
	return "p."..self.pattern[i]
end

function music_events:getrow(i)
	if (self.pattern[i]==-1 or self.row[i]>31) return "off"
	return "r"..self.row[i]
end

function music_events:drawfilt(i)
	if stat(57) and self.row[i]>=0 then
		local f=@(0x3240+self.pattern[i]*68)
		if (f&2>0) spr(12,-31,120)
		if (f&4>0) spr(13,-31,120)
		if (f\8%3==1) spr(14,-23,120)
		if (f\8%3==2) spr(15,-23,120)
		if (f\24%3==1) spr(3,-17,120)
		if (f\24%3==2) spr(4,-17,120)
		if (f\72%3==1) spr(7,-9,120)
		if (f\72%3==2) spr(8,-9,120)
	end
end

function drawmusframes(cy,f)
	camera(0,cy)
	
	local loopstart=00
	for frame=00,63 do
		local fdat=$(0x3100+frame*4)
		local stp,d,e=fdat<<8<0,5,6
		if (stp) d=2 e=8
		if frame==f then
			d=1 e=12
			if (stp) d=4 e=9
		end
		
		local dis=fdat|0xbfbf.bfbf==~0
		line(frame*2+1,0,frame*2+1,3,dis and d or e)
		if fdat<<24<0 then
			pset(frame*2+1,1,3)
			loopstart=frame
		end
		if fdat<<16<0 then
			line(loopstart*2+1,2,frame*2+1,2,11)
			pset(frame*2+1,3,3)
		end
	end
	
	camera()
end


-->8
--gameover

svg_gameover={
{7,175,63,175,63,165,63,165,63,165,63,161,70,161,70,161,70,162,72,162,72,162,72,171,71,171,71},
{7,139,62,139,62,142,73,142,73},
{7,134,68,134,68,139,68,139,68},
{7,144,58,144,58,138,60,138,60,138,60,129,72,129,72},
{7,133,57,133,57,127,72,127,72,127,72,112,73,112,73},
{7,130,60,130,60,127,59,127,59,127,59,121,60,121,60,121,60,118,65,118,65,118,65,120,67,120,67,120,67,126,67,126,67},
{7,143,71,143,71,148,62,148,62,148,62,151,69,151,69,151,69,156,62,156,62,156,62,160,72,160,72},
{7,166,66,166,66,173,66,173,66},
{7,219,82,219,82,227,63,227,63,227,63,237,63,237,63,237,63,238,65,238,65,238,65,227,69,227,69,227,69,226,71,226,71,226,71,237,77,237,77},
{7,200,60,200,60,206,73,206,73,206,73,211,64,211,64},
{7,196,70,196,70,194,72,194,72,194,72,190,72,190,72,190,72,188,71,188,71,188,71,190,64,190,64,190,64,198,61,198,61,198,61,200,63,200,63,200,63,197,68,197,68},
{7,225,63,225,63,215,63,215,63,215,63,210,70,210,70,210,70,212,72,212,72,212,72,220,71,220,71},
{7,215,66,215,66,222,66,222,66},
}

--resets game for replay
--not title screen
function reset_game()
 ctx=ctx_gameplay
 stopsvg=true
 over=300
 tick=15
 blink=false
 svg=svg_title
 current_track=title_track
end

function end_countdown()
 ctx=ctx_scorecard
 music(-1,500) 
 svg=svg_title
 stopsvg=true
 print("end",20,20,8)
 camera()
 scorecard()
end

function check_continue()
 if btnp()&63>0 then
  do_continue()
	end 
end

function do_continue()
	_init()
 ctx=ctx_gameplay
	stopsvg=true
	music(-1,500)
	cls(flr(rnd(15)))
end


-->8
--highscore

scores={}
function load_scores()
 scores={354,1,865,234,23,76,34,98,25,67,12,098,223,456,876,1000,500}
end

gaps={}
function shellsort(a)
    for gap in all(gaps) do
        for i=gap+1,#a do
            local x=a[i]
            local j=i-gap
            while j>=1 and a[j]>x do
                a[j+gap]=a[j]
                j-=gap
            end
            a[j+gap]=x
        end
    end
end

highscores={}
function topten(unsorted)
 gaps=unsorted
 --sort from low to high
 --store in scores
 shellsort(unsorted)
 local cnt=0
 for i=#unsorted,1,-1 do
  --sort top ten, highest first
  if(cnt<10) add(highscores,unsorted[i])
  cnt+=1
 end
end
-->8
--animation

-- ========================== 
-- easing
-- ========================== 

 ezcy=-100
 ezby=100
 ezd=128--60 (snappier)
 ezt=0
function init_easing()
 ezt+=1
 local st=6
	if ezt<=ezd then
		title_y=easing(ezt,ezby,ezcy,ezd,st)
	end
end

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
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000999900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000009900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a0000000888888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aa000000088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaa00000008880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaa0000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
aaaaaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100010100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d1100000000000000002146000210b11000141021200e01002140020200e11002040021200e010021400e010000000000002146000210b11000041021200e01002140020200e11002040021200e010021400e010
01100000000000000000140021201011005040021200e01000140021201011002040021200e000021400e000021000410000140021201011005040021200e01000140021201011002040021200e000021400e000
__music__
00 08404344
00 08424344
00 09424344
02 08424344

