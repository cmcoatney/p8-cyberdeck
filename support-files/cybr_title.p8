pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--core

function _init()
 set_svgcenter()
 refresh(0,0,0)
end


function _update60()
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
 
 
 if(svgglitch==true) glitch()
 current_track=title_track
 
 play()
end

function glitch()
 --if(not flr(rnd(1000))) svgcol=rnd(col)
svgcol=8
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

function _draw()
--x,y require offset of -64
 title()
end 

-->8
--title screen
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

--easing
 ezcy=-100
 ezby=100
 ezd=128--60 (snappier)
 ezt=0
 ty=64 --title y
function title()
 
 --line(-64,-ty+9,64,-ty+9,12)
 line(-64,-ty+8,64,-ty+8,8)
 --line(-64,-ty+7,64,-ty+7,7)
 spr(49,-64,-ty-28,1,1,false,false)
 spr(49,56,-ty-28,1,1,true,false)


 line(-64,-ty-59,64,-ty-59,10)
 line(-64,-ty-57,64,-ty-57,10)
 rectfill(-64,-ty-53,64,-ty-55,10)
 rectfill(-64,-ty-45,64,-ty-50,10)
 rectfill(-64,-ty-30,64,-ty-40,10)
 
 line(-64,-ty-28,64,-ty-28,10)

 rectfill(-64,36+ty,64,56,10)
 
 if(loading>0) print("press ❎",-14,18+ty,10)
 
 print("'*   #",58,35+ty,0)
 print("'*   #",40,55+ty,0)
 print("' : ` ~*...",-64,55+ty,0)
 print("loading...",-64+30,43+ty,0)
 
 spr(32,-64,28+ty,2,1,false,false)
 
 pal(8,0)
 spr(34,-64+70,36+ty,1,1,false,false)
 spr(35,-64+78,28+ty,1,1,false,false)
 
 spr(48,-72+96,36+ty,1,1,false,false)
 spr(48,-72+104,36+ty,1,1,false,false)
 spr(48,-72+112,36+ty,1,1,false,false)
 spr(48,-72+120,36+ty,1,1,false,false)
 
 

 
 spr(52+loading,-64+20,42+ty,1,1,false,false)
 
 pal()
 

 --play()
end

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


--svg
--draw svg 1.1
--by txori

--svg converted with https://www.txori.com/index.php?static14/pico8


--inkscape:
-- 1. press b on keyboard 
-- 2. choose spiro tool
-- 3. create a shape
-- 4. open in text editor
-- 5. select path string value
-- 6. in other words,
-- 7. what's between the quotes
-- 8. use the txori tool above
-- 9. replace the svg table below
-- 10. run cart
-- 11. first number is color

svgcol=7
svgglitch=false
svg={
{svgcol,5,30,5,30,11,32,11,32,11,32,39,31,39,31,39,31,41,29,41,29,41,29,42,30,42,30,37,34,33,39,31,41,29,43,29,43,30,43,31,42,32,41,33,40,34,40,36,39,37,39,42,34,47,30,49,27,51,25,51,25,51,25,51,25,47,25,47,25,47,25,42,28,42,28,42,28,43,24,43,24,43,24,40,25,40,25,40,25,39,28,39,28,39,28,36,27,36,27,36,27,36,28,36,28,36,28,21,28,21,28,21,28,37,21,37,21,37,21,39,22,39,22,39,22,42,20,42,20,42,20,38,18,38,18,29,21,20,25,15,27,9,29,7,29,5,30},
{svgcol,65,15,65,15,65,15,64,14,64,14,60,19,60,19,60,19,59,19,59,19,59,19,44,33,44,33,44,33,48,35,48,35,48,35,61,28,61,28,61,28,58,32,58,32,58,32,60,33,60,33,60,33,71,32,71,32,71,32,72,30,72,30,72,30,64,31,64,31,64,31,64,29,64,29,64,29,72,29,72,29,72,29,73,27,73,27,73,27,66,27,66,27,67,27,68,27,69,27,70,26,70,26,70,26,70,26,75,26,75,26,75,26,70,35,70,35,70,35,73,37,73,37,73,37,76,31,76,31,76,31,89,35,89,35,89,35,91,33,91,33,91,33,91,32,91,32,91,32,92,33,92,33,92,33,108,30,108,30,108,30,113,25,113,25,113,25,97,23,97,23,97,23,93,30,93,30,93,30,90,31,90,31,90,31,90,32,90,32,90,32,83,30,83,30,83,30,94,27,94,27,94,27,92,25,92,25,92,25,76,24,76,24,76,24,76,25,76,25,76,25,65,25,65,25,65,25,63,26,63,26,63,26,63,25,62,25,61,25,59,25,57,25,57,25,63,19,63,19,63,19,63,17,63,17,64,17,64,16,65,15,65,15,65,15,65,15},
{svgcol,135,24,135,24,131,30,131,30,131,30,131,31,131,31,131,31,130,33,130,33,130,33,132,35,132,35,132,35,135,30,135,30,135,30,160,41,160,41,160,41,160,39,160,39,160,39,144,31,144,31,144,31,144,30,144,30,144,30,140,28,140,28,144,27,148,25,151,24,153,23,154,22,154,21,155,21,155,21,155,20,155,20,137,27,137,27,137,27,139,24,139,24,139,24,135,24,135,24},
{svgcol,112,25,111,26,109,29,107,31,107,31,109,33,109,33,109,33,120,31,120,31,120,31,121,29,121,29,121,29,112,30,112,30,112,30,113,29,113,29,113,29,120,28,120,28,120,28,122,26,122,26,122,26,115,26,115,26,115,26,118,26,118,26,118,26,119,26,119,26,119,26,123,26,123,26,123,26,125,24,125,24,121,24,117,24,115,24,113,24,113,24,112,25},
{svgcol,130,22,130,22,120,30,120,30,120,30,122,33,122,33,122,33,130,35,130,35,130,35,132,35,132,35,132,35,124,30,124,30,124,30,130,24,130,24,130,24,130,22,130,22},
{svgcol,55,27,55,27,51,30,51,30,54,29,57,28,57,28,58,27,56,27,55,27},
{svgcol,78,26,78,26,77,28,77,28,77,28,78,28,78,28,78,28,86,27,86,27,86,27,78,26,78,26},
{svgcol,101,26,101,26,99,29,99,29,99,29,107,28,107,28,107,28,108,27,108,27,108,27,101,26,101,26},

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

--easing


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

--easing




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
0000000000000000aaa888aa88888888000000000000000000000000000000002222020200202222cc4447777774cccc00000000ccccc000cc000cc000000000
0000000000000000aaaa8aaa888888880000000000000000000000000000000022200007f0020022cc44777777774ccc000ccccccccccccc0ccccccc00000000
0000000000000000aaaaaaaa88888888000000000000000000000000000000002200700000070222cc47777777774ccc00cc0000000000000000000c00000000
0000000000000000aaaaaaaa8888888800000000000000000000000000000000200700ffff007022ccf7707777074ccc0cc00555555555555500000c00000000
0000000000a00000aaaaaaaa88888888000000000000000000000000000000002200000000000002cf77707777074ccc0c000555555555555000000c00000000
aaaaaaaaaaaa0000aaaaaaaa8aaa8888000000000000000000000000000000002000888008880022cf47777777774ccccc000555555555550050000c00000000
aaaaaaaaaaaaa000aaaaaaaaaaaaa8880000000000000000000000000000000028708880088807c2cc47774444475cccc0000555555555555550000c00000000
aaaaaaaaaaaaaaaa0000000000000000aa8888aaaa8888aaaa8888aaaa8888aa2c708880088807b27744f4fffff45777c0000555555555555550000c00000000
88aaaaa8aaaaaaa00000000000000000a899998aa899998aa899998aa899998a222f000ff000f222774444f445f54777c0005555555555555550000c00000000
8aaaaa88aaaaaa00000000000000000089cc889889cc8898898888988988889822200ffffff00222775444f444f45777c0055555555555555550000c00000000
aaaaa888aaaaa000000000000000000089c8889889c888988988889889888898220000f44f0000227704444445457777c0005500000000000000000c00000000
aaaa888aaaaa00000000000000000000898888988988889889888c9889c8889822200000000002227774444454577777c0000000000000000000000c00000000
aaa888aaaaa00000000000000000000089888898898888988988cc9889cc88982222000ff00022227777444545477777cc00000000cccc00000000cc00000000
aa888aaaaa0000000000000000000000a899998aa899998aa899998aa899998a222220000002222277777454547777770ccc00cccc000ccc000cccc000000000
aaaaaaaaa00000000000000000000000aa8888aaaa8888aaaa8888aaaa8888aa22222200002222227777777777777777000ccc0000000000cccc000000000000
70007077777000777000777077707777707000070770777788aa88888888aa887077777700070007777707077777770000007700000000070000000070007777
70707077000070007070007070000000707077770700000088aa88888888aa887000000007070707700007000000000777707707707707070777707000700000
00707077077777770077707077077077707000000777777088aabb8888bbaa887077777707770707007777770777777000707707707007070700007007707770
77777000007070007070000000070000707770707770000088aabb8888bbaa887070000000070707070007000000007070700007707707070777777000000700
007077707077707700007707777777777070007077707777aa88aaaaaaaa88aa7077077007077707000707700777777070777707707007070700000007077770
707070707000707077707000700700007077077707700000aa88aaaaaaaa88aa7070007007000707077777700000700070007000707707070777777707070770
707070707770707700700077770707707070000007007770aaaa88888888aaaa0070707077777777000007000777777000770070700777070700000000000000
700000707770000770707070770777707070777707700700aaaa88888888aaaa7777707000070000770777070070000070700777770000070777777707777770
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

