;**** Function RGBtoHex(R,G,B) 
;**** R,G and B are decimals. Returned is a hex e.g. 0xFFACBC 
RGBtoHex(R,G,B) 
{ 
   local Ret_Val 
   SetFormat, Integer, Hex 
   Ret_Val := (R << 16) | (G << 8) | B 
   SetFormat, Integer, D 
   return, Ret_Val 
}