; ********************************* 
; ********************************* 
; Original versions of ExtractInteger and InsertInteger provided by Chris 
; - from the AutoHotkey help file - Version 1.0.37.04 
; ********************************* 
; ********************************* 
ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) 
; pSource is a string (buffer) whose memory area contains a raw/binary integer at pOffset. 
; The caller should pass true for pSigned to interpret the result as signed vs. unsigned. 
; pSize is the size of PSource's integer in bytes (e.g. 4 bytes for a DWORD or Int). 
; pSource must be ByRef to avoid corruption during the formal-to-actual copying process 
; (since pSource might contain valid data beyond its first binary zero). 
{ 
   SourceAddress := &pSource + pOffset  ; Get address and apply the caller's offset. 
   result := 0  ; Init prior to accumulation in the loop. 
   Loop %pSize%  ; For each byte in the integer: 
   { 
      result := result | (*SourceAddress << 8 * (A_Index - 1))  ; Build the integer from its bytes. 
      SourceAddress += 1  ; Move on to the next byte. 
   } 
   if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
      return result  ; Signed vs. unsigned doesn't matter in these cases. 
   ; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart: 
   return -(0xFFFFFFFF - result + 1) 
}