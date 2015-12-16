; ********************************* 
; ********************************* 
; Original versions of ExtractInteger and InsertInteger provided by Chris 
; - from the AutoHotkey help file - Version 1.0.37.04 
; ********************************* 
; ********************************* 
InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4) 
; To preserve any existing contents in pDest, only pSize number of bytes starting at pOffset 
; are altered in it. The caller must ensure that pDest has sufficient capacity. 
{ 
   mask := 0xFF  ; This serves to isolate each byte, one by one. 
   Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
   { 
      DllCall("RtlFillMemory", UInt, &pDest + pOffset + A_Index - 1, UInt, 1  ; Write one byte. 
         , UChar, (pInteger & mask) >> 8 * (A_Index - 1))  ; This line is auto-merged with above at load-time. 
      mask := mask << 8  ; Set it up for isolation of the next byte. 
   } 
} 
