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
function title()
 draw_upper_panel()
 draw_lower_panel()

 local eez=0
 if (ezt<=ezd) eez=easing(ezt,ezby,ezcy,ezd,11)

 local call_to_action="press ❎"
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

svg={
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
	if btnp()&63>0 and not config.active and not screensaver.enabled or not stat(57) then
		if (arg[1]~="") extcmd"go_back"
		menuitem(1,"toggle file mode",toggle_filemode)
		screensaver.enabled=false
		music(-1,500)
		track.is_playing=false
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

