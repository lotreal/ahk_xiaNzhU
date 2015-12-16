; ********************************* 
; Modified version of ExtractInteger 
; ********************************* 
ExtractIntegerA(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4) ; modA 
{ 
  VarSetCapacity(struct_retval, 64000) 
  pOffset := pOffset * 4 
  SourceAddress := &pSource + pOffset 
  result := 0 
  Loop %pSize% 
  { 
    result := result | (*SourceAddress << 8 * (A_Index - 1)) 
    SourceAddress += 1 
  } 
  if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
    return result ; struct_retadd := result 
  else 
    struct_retadd := -(0xFFFFFFFF - result + 1) 
  struct_retval= 
  DllCall("lstrcpyA", "str", struct_retval, "int", struct_retadd) 
  Return %struct_retval% 
}