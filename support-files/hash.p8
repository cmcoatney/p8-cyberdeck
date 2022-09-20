pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--hash
--based on md5 hash
--https://www.comparitech.com/blog/information-security/md5-algorithm-with-examples/
--rotr https://pico-8.fandom.com/wiki/rotr


--video js: https://www.youtube.com/watch?v=uoxtmoctezk

token="they are deterministic"
bit=0
zer=0
function _draw()
cls()
print("128 bit simple hash")

print("tok:"..token,8)
print("len:"..#token,7)
bit=(#token*8)
print("bit:"..bit)
zer=448-1-bit
print("")
print("padding is leading 1 + x zeroes")
print("of 512, 448-1-"..bit.."=zeroes")
print("zer:"..zer)

bin = hash(token)


end

function hash(input)
 local str=""
 local arr={}
 local ttl=0
 for i=1,#input do
 local c = sub(input,i,i+1)
  local d=ord(c)
  local b=dtb_8(d)
  ttl+=1
  add(arr,b)
 end
 print("bin:"..#arr)
 local pad_arr=pad(arr)
 print("pad:"..#pad_arr)
 print("bit:"..(#pad_arr*8))
 print("")
 local arr2=cat(arr,pad_arr)
 print("chk:"..(#arr2*8).." = 448",8)

 print("",7)
 print("last 64 bits stores token length")

 local tkc=#token
 local tkb=dtb_8(tkc)
 print("str:"..(#token*8) .." = "..tkb.." = "..(#tkb*8))
 
 add(arr2,tkb)
 print("",7)
 print("chk:"..(#token*8)+(#pad_arr*8)+(#tkb*8).."="..(#token*8).."+"..(#pad_arr*8).."+"..(#tkb*8),8)
 
 return arr2
end

--pad with zeroes
function pad(arr)
 local len = #arr*8
 local padding=(448-1-len)
 local zeroes="00000000"
 local result ={}

 for cnt=0, padding,8 do
   add(result,zeroes) 
 end

 return result
end

--decimal to bin 8
function dtb_8(num)
  local bin=""
  for i=7,0,-1do
    bin..=num\2^i %2
  end
  return bin
end

--decimal to bin 16
function dtb_16(num)
  local bin=""
  for i=1,16 do
    bin=num %2\1 ..bin
    num>>>=1
  end
  return bin
end

--concatenate tables
function cat(a1,a2)

 local arr=a1
 
 for el in all(a2) do
  add(arr,el)
 end
 
 return arr
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
