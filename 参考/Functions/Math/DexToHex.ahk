;**** Function DecToHex(In_Val) 
;**** Returns a decimal as Hex with leading "0x" 
;**** E.g. 255 => 0xFF |-255 => 0xFFFFFFFFFFFFFF01 
;**** WARNING: NOT SURE IF I DID IT THE RIGHT WAY 
DecToHex(In_Val) 
{ 
   local Ret_Val 
   SetFormat, Integer, Hex 
   if (In_Val>=0) 
      Ret_Val :=In_Val*1 
   else 
      Ret_Val :=In_Val+0xFFFFFFFFFFFFFFF+1  
   SetFormat, Integer, D 
   return, Ret_Val 
}