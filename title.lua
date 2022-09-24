--title screen
title_y=64 
loading_cnt=0
cam_offset=64
function title()
 draw_upper_panel()
 draw_lower_panel()

 local eez=0
 if (ezt<=ezd) eez=easing(ezt,ezby,ezcy,ezd,11)

 local call_to_action="press ❎"
 print(call_to_action,hcenter(call_to_action),72+eez,12)
end

function draw_upper_panel()
 rectfill(30,0-title_y,100,6-title_y,10)
 rectfill(0,14-title_y,127,20-title_y,10)
 line(0,18-title_y,127,18-title_y,0)

 rectfill(0,26-title_y,127,30-title_y,10)
 line(0,27-title_y,127,27-title_y,0)
 spr(48,0,31-title_y,1,1,false,true)
 spr(48,120,31-title_y,1,1,true,true)

 --blackout
 rectfill(23,7-title_y,106,17-title_y,0)
 rectfill(27,18-title_y,102,21-title_y,0)

--diagonal overlays
 line(23,13-title_y,29,0-title_y,10)
 line(23,14-title_y,29,1-title_y,10)
 line(23,16-title_y,29,3-title_y,10)
 line(23,17-title_y,29,5-title_y,10)

 line(100,0-title_y,106,13-title_y,10)
 line(100,1-title_y,106,14-title_y,10)
 line(100,3-title_y,106,16-title_y,10)
 line(100,6-title_y,106,17-title_y,10)

 line(27,21-title_y,31,25-title_y,10) 
 line(27,20-title_y,36,25-title_y,10) 
 line(27,21-title_y,35,25-title_y,10) 
 line(27,20-title_y,33,25-title_y,10) 
 line(27,20-title_y,32,25-title_y,10) 
 line(26,19-title_y,38,25-title_y,10) 

 line(102,20-title_y,89,26-title_y,10)
 line(103,20-title_y,98,25-title_y,10) 
 line(103,20-title_y,97,25-title_y,10) 
 line(103,21-title_y,95,25-title_y,10) 
 line(103,20-title_y,93,25-title_y,10) 
 line(103,21-title_y,99,25-title_y,10) 
end

function draw_lower_panel()
 spr(48,20,92+title_y,1,1,false,false)
 rectfill(0,92+title_y,20,100+title_y,10)
 spr(48,88,90+title_y,1,1,false,false)
 rectfill(84,90+title_y,88,100+title_y,10)
 spr(48,76,90+title_y,1,1,true,false)
 rectfill(0,96+title_y,127,120+title_y,10)
 pal(8,0)
 spr(49,70,96+title_y)
 pal()

 local subtitle="hackerz\nprofile"
 print(subtitle,35,104+title_y,0)

 draw_hazard_tape_pattern()
 draw_zero_one()
end

function draw_hazard_tape_pattern()
 local y_offset=98+title_y
 local x_offset=80

 for i=x_offset,x_offset+60,4 do
  line(i,y_offset,8+i,y_offset+8,0)
  line(i,y_offset+1,8+i,y_offset+8+1,0)
 end
 --trim around stripes for cleaner look
 rectfill(80,106+title_y,127,108+title_y,10)
 rectfill(80,98+title_y,127,100+title_y,10)
 rectfill(81,98+title_y,85,108+title_y,10)
end

function draw_zero_one()
 --vertical
 rectfill(4,100+title_y,6,118+title_y,0)
 rectfill(10,100+title_y,12,118+title_y,0)

 rectfill(18,100+title_y,20,118+title_y,0)

 --horizontal
 rectfill(4,100+title_y,12,102+title_y,0)
 rectfill(4,116+title_y,12,118+title_y,0)
 rectfill(16,116+title_y,22,118+title_y,0)
 rectfill(16,100+title_y,20,102+title_y,0)
end


--easing
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