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