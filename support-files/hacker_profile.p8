pico-8 cartridge // http://www.pico-8.com
version 38
__lua__

msg=""
function _init()
  hacker1=create_hacker()
  hacker2=create_hacker()
  hacker3=create_hacker()
end

function _update()
 timer()

end

function _draw()
 cls()
 
 print("the name length",2,20)
 print("should not decide",2,26)
 print("emoticon fullness",2,32)

 draw_hacker(1,hacker1)
 
 draw_hacker(2,hacker2)
 
 draw_hacker(3,hacker3)
 
 print(msg,2,120,8)
end

tick=180
function timer()
tick-=1
 if tick<0 then
   hacker1=create_hacker()
   hacker2=create_hacker()
   hacker3=create_hacker()
   tick=180
 end
end

function copy(o)
  local c
  if type(o) == 'table' then
    c = {}
    for k, v in pairs(o) do
      c[k] = copy(v)
    end
  else
    c = o
  end
  return c
end

-->8
--hackers

hackers={}
function create_hacker()
 local hacker={}
 hacker.hat=rnd(hats)
 hacker.col=0
 hacker.name=get_rnd_name()
 hacker.hash=""
 hacker.bits={}
 hacker.deck=255
 hacker.armor=4
 hacker.stole=true
 hacker.d_hat=false
 hacker.d_name=false
 add(hackers,hacker)
 
 local bin=hash(hacker.name)
 local cnt=1
 for b in all(bin) do
  hacker.hash=hacker.hash.." "..encode(b)
  if(cnt==1) hacker.col=b
  if(cnt < 16) add(hacker.bits,(b%2)==0)
  cnt+=1
 end
 
  --first char
 --col=ord(code)
 
 return hacker
end

function draw_hacker(position,hacker)
 local y_off=0
 
 if(position==1) y_off=0
 if(position==2) y_off=42
 if(position==3) y_off=84
 
 --print((hacker.hash), 34,70+y_off,8)
 print(hacker.name, 11*8,32+y_off,8)
 
 printhat(hacker.hat,(11*8),0+y_off)
 spr(2,11*8,8+y_off)
 if(hacker.stole) spr(7,11*8,20+y_off)
 draw_identicon(hacker.col,hacker.bits,101,2+y_off)

end

blue=12  --vengeful noob
green=11 --noob
red=8    --vigilante
grey=6   --unethical
white=7  --ethical
black=5  --malicious
hats={white,black,grey,blue,red,green}
function printhat(col, x, y)
 pal(7,col,0)
 spr(1,x,y)
 pal()
end



-->8
-- name generator

--https://gamedev.stackexchange.com/questions/129046/how-to-automatically-generate-creative-names-for-stuff
--1. take a bunch of real-world names for the entities (cities, countries, male people, female people...) you want to name. when your game is inspired by a specific culture and you want to emulate the naming style in your game, you might want to do this with names from that cultural circle.
--2. separate them into syllables and create three lists: start syllables, middle syllables and end syllables.
--3. to generate a name, concatenate a random syllable from the start list, 0-4 syllables from the middle-list and one syllable from the end-list.

--https://www.samcodes.co.uk/project/markov-namegen/

-- 1. gather generic names
-- from steampunk/cyberpunk
-- sources
-- 2. split into start, middle
-- and end syllables
-- 3. randomly choose one
-- of each category

--s=start
--m=middle
--e=ending

names_phonemes = {
{ s = 'da', m = 'n', e = 'se' }, 
{ s = 'jer', m = '', e = 'rik' }, 
{ s = 'as', m = 'i', e = 'mov' }, 
{ s = 'vik', m = '', e = 'tor' }, 
{ s = 'de', m = 'exe', e = 'ter' }, 
{ s = 'ro', m = 'y', e = 'ce' }, 
{ s = 'no', m = 'o', e = '' }, 
{ s = 'trin', m = 'it', e = 'y' }, 
{ s = 'clu', m = '', e = 'tch' }, 
{ s = 'cog', m = 'lio', e = 'stro' }, 
{ s = 'arm', m = 'i', e = 'tage' }, 
{ s = 'bi', m = 'shop', e = '' }, 
{ s = 'gun', m = '', e = 'nar' }, 
{ s = 'harv', m = '', e = '' }, 
{ s = 'lu', m = '', e = 'kas' }, 
{ s = 're', m = '', e = 'zin' }, 
{ s = 'ge', m = 'nea', e = 'va' }, 
{ s = 'mis', m = '', e = 'ty' }, 
{ s = 're', m = '', e = 'zin' },
{ s = 'ev', m = 'e', e = 'lyn' },
{ s = 'ist', m = '', e = 'zla' },
{ s = 'il', m = '', e = 'sa' },
{ s = 'max', m = '', e = 'ine' },
{ s = 'do', m = '', e = 'ra' },
{ s = 'yu', m = '', e = 'ki' },
{ s = 'ma', m = '', e = 'ko' },
{ s = 'aer', m = '', e = 'is' },
{ s = 'deck', m = '', e = 'er' },
{ s = 'dr', m = '', e = 'edd' },
{ s = 'au', m = 'ro', e = 'ra' },
{ s = 'gos', m = 'sym', e = 'er' },
{ s = 'a', m = '', e = 'va' },
{ s = 'sa', m = 'bine', e = '' },
{ s = 'alt', m = '', e = '' },
{ s = 'mael', m = '', e = 'strom' },
{ s = 'stark', m = '', e = '' },
{ s = 'mav', m = 'er', e = 'ik' },
{ s = 'cryp', m = '', e = 'to' },
{ s = 'un', m = 'es', e = 'cape' },
{ s = 'to', m = '', e = 'ken' },
{ s = 'jer', m = 'ich', e = 'o' },
{ s = 'lo', m = 'rek', e = '' },
{ s = 'lo', m = '', e = 'rez' },
{ s = 'ga', m = '', e = 'spar' },
{ s = 'nau', m = 'ti', e = 'lus' },
{ s = 'ne', m = '', e = 'mo' },
{ s = 'ag', m = 'a', e = 'tha' },
{ s = 'bri', m = '', e = 'ar' },
{ s = 'er', m = '', e = 'lys' },
{ s = 'es', m = 'trel', e = 'la' },
{ s = 'u', m = 'mek', e = 'ki' },
{ s = 'scar', m = '', e = 'let' },
{ s = 'si', m = '', e = 'byl' },
{ s = 'o', m = 'ka', e = 'mi' }}


function get_rnd_name()
 return  rnd(names_phonemes)["s"]..rnd(names_phonemes)["m"]..rnd(names_phonemes)["e"]
end

--print(get_rnd_name())
--danse
--jerrik
--asimov
--viktor
--dexter
--royce
--neo
--trinity
--clutch
--cogliostro
--armitage
--bishop
--gunnar
--harv
--lucas
--rezin
--geneva
--misty
--evelyn
--istla
--maxine
--dore
--yuki
--mako
--aeris
--decker
--dredd
--aurora
--gossymer
--ava
--sabine
--alt
--maelstrom
--stark
--maverick
--crypto
--unescape
--token
--jericho
--lorek
--lorez
--gaspar
--nautilus
--nemo
--agatha
--briar
--erlys
--estrella
--umeki
--scarlet
--sybil
--okami







-->8
--hash functions

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
 
 local pad_arr=pad(arr)
 local arr2=cat(arr,pad_arr)
 local tkc=#input
 local tkb=dtb_8(tkc)
 add(arr2,tkb)
 
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


--digest binary in byte size
--chunks returning a char code
function encode(bits)
  local code = bits
  msg=bits
  if bits=="0001" then
   code= "a"
  elseif bits=="0011" then
   code= "b"  
  elseif bits=="0111" then
   code= "c" 
  elseif bits=="1111" then
   code= "d" 
  elseif bits=="1110" then
   code= "e" 
  elseif bits=="1100" then
   code= "f" 
  elseif bits=="1000" then
   code= "g" 
  elseif bits=="0010" then
   code= "h" 
  elseif bits=="0100" then
   code= "i" 
  elseif bits=="1001" then
   code= "j"     
  else  
   --0000
   code = flr(rnd(10))
  end
 
  return code
end
-->8
--identicon

function printbits(bits)
 local bit=""
 for b in all(bits) do
 local t=""
 if b==true then
  t="t"
 else
 t="f"
 end
  bit=bit..t
 end
 msg=bit
end

function draw_identicon(col,bits,x1,y1)
 printbits(bits)
 
 rect(x1-2,y1-2,x1+26,y1+26,7)
 if(bits[1]) rectfill(x1,y1,x1+4,y1+4,col)
 if(bits[2]) rectfill(x1+5,y1,x1+9,y1+4,col)
 if(bits[3]) rectfill(x1+10,y1,x1+14,y1+4,col)
 if(bits[2]) rectfill(x1+15,y1,x1+19,y1+4,col)
 if(bits[1]) rectfill(x1+20,y1,x1+24,y1+4,col)

 if(bits[4]) rectfill(x1,y1+5,x1+4,y1+9,col)
 if(bits[5]) rectfill(x1+5,y1+5,x1+9,y1+9,col)
 if(bits[6]) rectfill(x1+10,y1+5,x1+14,y1+9,col)
 if(bits[5]) rectfill(x1+15,y1+5,x1+19,y1+9,col)
 if(bits[4]) rectfill(x1+20,y1+5,x1+24,y1+9,col)

 if(bits[7]) rectfill(x1,y1+10,x1+4,y1+14,col)
 if(bits[8]) rectfill(x1+5,y1+10,x1+9,y1+14,col)
 if(bits[9]) rectfill(x1+10,y1+10,x1+14,y1+14,col)
 if(bits[8]) rectfill(x1+15,y1+10,x1+19,y1+14,col)
 if(bits[7]) rectfill(x1+20,y1+10,x1+24,y1+14,col)

 if(bits[10]) rectfill(x1,y1+15,x1+4,y1+19,col)
 if(bits[11]) rectfill(x1+5,y1+15,x1+9,y1+19,col)
 if(bits[12]) rectfill(x1+10,y1+15,x1+14,y1+19,col)
 if(bits[11]) rectfill(x1+15,y1+15,x1+19,y1+19,col)
 if(bits[10]) rectfill(x1+20,y1+15,x1+24,y1+19,col)

 if(bits[13]) rectfill(x1,y1+20,x1+4,y1+24,col)
 if(bits[14]) rectfill(x1+5,y1+20,x1+9,y1+24,col)
 if(bits[15]) rectfill(x1+10,y1+20,x1+14,y1+24,col)
 if(bits[14]) rectfill(x1+15,y1+20,x1+19,y1+24,col)
 if(bits[13]) rectfill(x1+20,y1+20,x1+24,y1+24,col)

end
__gfx__
00000000000000006666666666666666666666666666666666666666000aa0000000000000000000000000000000000000000000000000000000000000000000
00000000000770006333bbb66333000660000006600000066000000600aaaa000000000000000000000000000000000000000000000000000000000000000000
00700700007777006333bbb6633300066000000660000006600000060a7aa9a00000000000000000000000000000000000000000000000000000000000000000
00077000007777006333bbb6633300066000000660000006600000060aaaa9a00000000000000000000000000000000000000000000000000000000000000000
00077000700000076111ccc66111ccc66111ccc66000ccc6600000060aaaa9a00000000000000000000000000000000000000000000000000000000000000000
00700700077777706111ccc66111ccc66111ccc66000ccc6600000060a9aa9a00000000000000000000000000000000000000000000000000000000000000000
00000000000000000611cc600611cc600611cc600600cc600600006000a99a000000000000000000000000000000000000000000000000000000000000000000
00000000000000000066660000666600006666000066660000666600000aa0000000000000000000000000000000000000000000000000000000000000000000
