; ********************************* 
; 
; ********************************* 
; AHK Function Library - Structures 
; Version 1.04 Beta 
; - by Corrupt 
; - August 10, 2005 
; ********************************* 
; 
; ********************************* 
;  Comments, suggestions, etc... welcome :) 
; 
; ********************************* 
; Create a new structure 
; ********************************* 
; Params: "Structure Name", "VarType", "VarName", "Type", "Name", etc... 
; - Currently a maximum of 32 variables in a structure is allowed 
; ********************************* 
struct_new(struct_name 
,s_type1="", s_var1="" 
,s_type2="", s_var2="" 
,s_type3="", s_var3="" 
,s_type4="", s_var4="" 
,s_type5="", s_var5="" 
,s_type6="", s_var6="" 
,s_type7="", s_var7="" 
,s_type8="", s_var8="" 
,s_type9="", s_var9="" 
,s_type10="", s_var10="" 
,s_type11="", s_var11="" 
,s_type12="", s_var12="" 
,s_type13="", s_var13="" 
,s_type14="", s_var14="" 
,s_type15="", s_var15="" 
,s_type16="", s_var16="" 
,s_type17="", s_var17="" 
,s_type18="", s_var18="" 
,s_type19="", s_var19="" 
,s_type20="", s_var20="" 
,s_type21="", s_var21="" 
,s_type22="", s_var22="" 
,s_type23="", s_var23="" 
,s_type24="", s_var24="" 
,s_type25="", s_var25="" 
,s_type26="", s_var26="" 
,s_type27="", s_var27="" 
,s_type28="", s_var28="" 
,s_type29="", s_var29="" 
,s_type30="", s_var30="" 
,s_type31="", s_var31="" 
,s_type32="", s_var32="") 
{ 
  Global 
  Local struct_sizeA, struct_sizeB, struct_temp1, struct_temp2 
  struct_ndeclare = %struct_name% 
  struct_temp= 
  ; count number of vars 
  Loop, 32 
  { 
    If s_type%A_Index% 
      struct_sizeB := A_Index * 4 
    Else 
      break 
  } 
  ; Set Size of structure and initialize all values with 0 
  VarSetCapacity(%struct_ndeclare%, struct_sizeB) 
    
  Loop, 32 
  { 
    If s_type%A_Index% 
    { 
      struct_mdeclare := s_var%A_Index% 
      struct_sizeA := (StrLen(struct_mdeclare) + 1) 
      ; Initialize Index varables 
      VarSetCapacity(%struct_name%_V%A_Index%, struct_sizeA) 
      %struct_name%_V%A_Index% := s_var%A_Index% 
      ; Initialize Type references 
      VarSetCapacity(%struct_name%_T%A_Index%, "6") 
      %struct_name%_T%A_Index% := s_type%A_Index% 
      ; Check Type 
      If s_type%A_Index% = Int 
      { 
        %struct_ndeclare%?%struct_mdeclare%:=0 
        InsertIntegerA(%struct_ndeclare%?%struct_mdeclare%, struct_ndeclare, ((A_Index - 1))) 
      } 
      Else 
      { 
        ; Assign a value to initialize the variable and get a pointer 
        %struct_ndeclare%?%struct_mdeclare%:="xxx" 
        InsertIntegerA(&%struct_ndeclare%?%struct_mdeclare%, struct_ndeclare, ((A_Index - 1))) 
  
        ; Clear the variable but keep the pointer (hopefully... not tested...) 
        %struct_ndeclare%?%struct_mdeclare%= 
        InsertIntegerA(&%struct_ndeclare%?%struct_mdeclare%, struct_ndeclare, ((A_Index - 1))) 
      } 
    } 
    Else 
      Break 
  } 
  struct_mdeclare= 
  struct_ndeclare= 
Return 
} 
; ********************************* 
; Update all values in structure 
; ********************************* 
; Default - retrieve values from structure and store in associated variables 
; Specify "S" as the second param to send values to the structure instead 
; ********************************* 
struct_update(struct_name, VarToStruct="") 
{ 
  Global 
  Local struct_temp1, struct_temp2, struct_temp3 
  struct_ndeclare = %struct_name% 

  ; Send values to structure 
  If VarToStruct = S 
  { 
    Loop, 32 
    { 
      struct_mdeclare := %struct_name%_V%A_Index% 
      if %struct_mdeclare% 
      { 
        ; determine offset 
        struct_temp2 := A_Index - 1 
        ; determine variable type 
        struct_temp3 := %struct_name%_T%A_Index% 
        If %struct_temp3% = Str 
        { 
          InsertIntegerA(&%struct_ndeclare%?%struct_mdeclare%, struct_ndeclare, ((A_Index - 1))) 
        } 
        Else 
        { 
          InsertIntegerA(%struct_ndeclare%?%struct_mdeclare%, struct_ndeclare, ((A_Index - 1))) 
        } 
      } 
      else 
      { 
        break 
      } 
    } 
  } 
  else 
  { 
    ; Retrieve values from structure 
    Loop, 32 
    { 
      struct_mdeclare := %struct_name%_V%A_Index% ; struct_var 
      if %struct_mdeclare% 
      { 
        struct_temp2 := A_Index - 1 
        %struct_ndeclare%?%struct_mdeclare% := ExtractIntegerA(%struct_name%, struct_temp2) 
      } 
      else 
      { 
        break 
      } 
    } 

  struct_mdeclare= 
  struct_ndeclare= 
  } 
Return 
} 
; ********************************* 
; Modify value stored in structure 
; ********************************* 
; "StructName?VarName", "ValueToAssign" 
; - the 3rd param is not functional in this version 
; ********************************* 
struct_mod(struct_var, s_value, s_type="") 
{ 
  Global 
  Local struct_found, s_struct, s_item, struct_temp1 
  StringTrimRight, s_struct, struct_var, % (StrLen(struct_var) - InStr(struct_var, "?") + 1) 
  StringTrimLeft, s_item, struct_var, % InStr(struct_var, "?") 
  ; Structure: s_struct 
  ; Variable: s_item 
  ; Value: s_value 
  struct_mdeclare := struct_var 
  struct_ndeclare := s_struct 

  ; Locate variable position in structure 
  Loop, 32 
  { 
    if %struct_ndeclare%_V%A_Index% = %s_item% 
    { 
      struct_found := A_Index 
      ; Check variable type 
      If %struct_ndeclare%_T%A_Index% = Str 
        struct_temp1 = Str 
      break 
    } 
  } 
  ; Assign values if found 
  if struct_found 
  { 
    struct_found-- 
    %struct_mdeclare% = %s_value% 
    If struct_temp1 = Str 
    { 
      InsertIntegerA(&%struct_var%, struct_ndeclare, struct_found) 
    } 
    Else 
    { 
      InsertIntegerA(%struct_var%, struct_ndeclare, struct_found) 
    } 
  } 
  Else 
    ErrorLevel = Not Found 
  struct_mdeclare= 
  struct_ndeclare= 
Return 
} 
; ********************************* 
; Retrieve a list of all variable names and values in a structure 
; ********************************* 
; "StructName", "DelimChar", "V" 
; - DelimChar may be character(s) to use to separate variable and value 
; - The info for each variable is separated by a `n character 
; - This function retrieves the values stored in the structure by default. 
; "V" can be specified as the 3rd param to retrieve the values from the 
; associated variables instead. 
; ********************************* 
struct_enum(struct_var, struct_delim2, struct_local="") 
{ 
  Global 
  Local struct_temp1, struct_temp2, struct_temp3, struct_temp4 
  struct_temp= 
  Loop, 32 
  { 
    struct_mdeclare := %struct_var%_V%A_Index% 
    if %struct_mdeclare% 
    { 
      ; determine offset value 
      struct_temp2 := A_Index - 1 
      ; output variable value 
      If struct_local = V 
      { 
        struct_temp4 = %struct_var%?%struct_mdeclare% 
        struct_temp3 := %struct_temp4% 
      } 
      else 
      { 
      ; else output value stored in structure 
        struct_temp3 := ExtractIntegerA(%struct_var%, struct_temp2) 
      } 
      if A_Index = 1 
        struct_temp1 = %struct_var%?%struct_mdeclare%%struct_delim2%%struct_temp3% 
      else 
        struct_temp1 = %struct_temp1%`n%struct_var%?%struct_mdeclare%%struct_delim2%%struct_temp3% 
    } 
    else 
    { 
      break 
    } 
  } 
  struct_temp= 
  struct_mdeclare= 
  struct_ndeclare= 
Return, %struct_temp1% 
} 
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
; ********************************* 
; ********************************* 
