--core
ctx=0
CTX_TITLE=0
CTX_GAMEPLAY=1
CTX_GAMEOVER=2
CTX_SCORECARD=3
CTX_OPTIONS=4

function _init()
 ctx=CTX_TITLE
end

function _update60()
 timer()
end

function _draw()
 cls()
 
 --draw context
 if(ctx==CTX_TITLE) title()
 if(ctx==CTX_GAMEPLAY) playgame()
 if(ctx==CTX_GAMEOVER) gameover()
 if(ctx==CTX_SCORECARD) scorecard()
 if(ctx==CTX_OPTIONS) options()
end

tick=30
function timer()
 tick-=1
 if tick < 0 then
  --do something
  tick=30
 end
end

--Drawing Contexts
 title_y=64 
 loading_cnt=0
 cam_offset=64
function title()
 draw_upper_panel()
 draw_lower_panel()

 local call_to_action="press ❎"
 local subtitle="hackerz\nprofile"
 print(call_to_action,hcenter(call_to_action),72,10)
 print(subtitle,35,104,0)

 
end

function draw_upper_panel()
 rectfill(30,0,100,6,10)
 rectfill(0,14,127,20,10)
 line(0,18,127,18,0)

 rectfill(0,26,127,30,10)
 line(0,27,127,27,0)
 spr(48,0,31,1,1,false,true)
 spr(48,120,31,1,1,true,true)

 --blackout
 rectfill(23,7,106,17,0)
 rectfill(27,18,102,21,0)

--diagonal overlays
 line(23,13,29,0,10)
 line(23,14,29,1,10)
 line(23,16,29,3,10)
 line(23,17,29,5,10)

 line(100,0,106,13,10)
 line(100,1,106,14,10)
 line(100,3,106,16,10)
 line(100,6,106,17,10)

 line(27,21,31,25,10) 
 line(27,20,36,25,10) 
 line(27,21,35,25,10) 
 line(27,20,33,25,10) 
 line(27,20,32,25,10) 
 line(26,19,38,25,10) 

 line(102,20,89,26,10)
 line(103,20,98,25,10) 
 line(103,20,97,25,10) 
 line(103,21,95,25,10) 
 line(103,20,93,25,10) 
 line(103,21,99,25,10) 
end

function draw_lower_panel()
 spr(48,20,92,1,1,false,false)
 rectfill(0,92,20,100,10)
 spr(48,88,90,1,1,false,false)
 rectfill(84,90,88,100,10)
 spr(48,76,90,1,1,true,false)
 rectfill(0,96,127,120,10)
 pal(8,0)
 spr(49,70,96)
 pal()

 draw_hazard_stripe()
 draw_zero_one()
end

function draw_hazard_stripe()
 local y_offset=98
 local x_offset=80

 for i=x_offset,x_offset+60,4 do
  line(i,y_offset,8+i,y_offset+8,0)
  line(i,y_offset+1,8+i,y_offset+8+1,0)
 end
 --trim
 rectfill(80,106,127,108,10)
 rectfill(80,98,127,100,10)
 rectfill(81,98,85,108,10)
end

function draw_zero_one()
 --vertical
 rectfill(4,100,6,118,0)
 rectfill(10,100,12,118,0)

 rectfill(18,100,20,118,0)

 --horizontal
 rectfill(4,100,12,102,0)
 rectfill(4,116,12,118,0)
 rectfill(16,116,22,118,0)
 rectfill(16,100,20,102,0)
end

function gameover()
 cls(8)
end

function scorecard()
 cls(7)
end

function playgame()
 map()
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
