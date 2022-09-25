
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