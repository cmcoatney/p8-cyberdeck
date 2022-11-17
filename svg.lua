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