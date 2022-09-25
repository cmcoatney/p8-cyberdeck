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