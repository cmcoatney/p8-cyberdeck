--title screen
title_y=64 
loading_cnt=0
cam_offset=64
blink=false
function title()
 draw_upper_panel()
 draw_lower_panel()

 local eez=0
 if (ezt<=ezd) eez=easing(ezt,ezby,ezcy,ezd,11)

 local call_to_action="press ❎"
 if(blink and eez==0) print(call_to_action,hcenter(call_to_action)-cam_offset,72+eez-cam_offset,12)
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


