; ********************************* 
; Modified version of Insert Integer 
; ********************************* 
InsertIntegerA(pInteger, ByRef pDest, pOffset = 0, pSize = 4) ; modA 
{ 
    ; MsgBox, variables Sent: pInteger: %pInteger%`npDest: %pDest%`noffset: %pOffset% ; test point 
    pOffset := pOffset * 4 
    mask := 0xFF 
    Loop %pSize% 
    { 
        DllCall("RtlFillMemory", UInt, &%pDest% + pOffset + A_Index - 1, UInt, 1, UChar, (pInteger & mask) >> 8 * (A_Index - 1)) 
        mask := mask << 8 
    } 
} 
