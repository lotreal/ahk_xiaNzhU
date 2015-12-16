; ChangeDisplaySettings.ahk 
; by shimanov 
; http://www.autohotkey.com/forum/viewtopic.php?t=8355 
/*
colorDepth = 32 ; bits (quality) 
screenWidth = 800 ; pixels 
screenHeight = 600 ; pixels 
refreshRate = 60 ; Hz (frequency) 


Return
*/
DispChangeSettings("32","800","600","60")
DispChangeSettings(colorDepth,ScreenWidth,ScreenHeight,refreshRate)
{
	; ChangeDisplaySettings.ahk 
	; by shimanov 
	; http://www.autohotkey.com/forum/viewtopic.php?t=8355
	struct_devicemode_size = 156 
	VarSetCapacity(device_mode, struct_devicemode_size, 0) 
	EncodeInteger(struct_devicemode_size, 2, &device_mode, 36) 
	success := DllCall("EnumDisplaySettings", "uint", 0, "uint", -1, "uint", &device_mode) 
	; DM_BITSPERPEL|DM_PELSWIDTH|DM_PELSHEIGHT|DM_DISPLAYFREQUENCY 
	EncodeInteger(0x00040000|0x00080000|0x00100000|0x00400000, 4, &device_mode, 40) 
	EncodeInteger(colorDepth, 4, &device_mode, 104) 
	EncodeInteger(screenWidth, 4, &device_mode, 108) 
	EncodeInteger(screenHeight, 4, &device_mode, 112) 
	EncodeInteger(refreshRate, 4, &device_mode, 120) 
	DllCall("ChangeDisplaySettings", "uint", &device_mode, "uint", 0) 
	Return
}
EncodeInteger( p_value, p_size, p_address, p_offset ) 
{ 
   loop, %p_size% 
      DllCall( "RtlFillMemory" 
         , "uint", p_address+p_offset+A_Index-1 
         , "uint", 1 
         , "uchar", ( p_value >> ( 8*( A_Index-1 ) ) ) & 0xFF ) 
}
/*
;Enumerate_StateFlags( p_flags ) 
{ 
   if ( p_flags & 0x1 ) 
      result = %result%|DISPLAY_DEVICE_ATTACHED_TO_DESKTOP 
   if ( p_flags & 0x8 ) 
      result = %result%|DISPLAY_DEVICE_MIRRORING_DRIVER 
   if ( p_flags & 0x8000000 ) 
      result = %result%|DISPLAY_DEVICE_MODESPRUNED 
   if ( p_flags & 0x4 ) 
      result = %result%|DISPLAY_DEVICE_PRIMARY_DEVICE 
   if ( p_flags & 0x20 ) 
      result = %result%|DISPLAY_DEVICE_REMOVABLE 
   if ( p_flags & 0x10 ) 
      result = %result%|DISPLAY_DEVICE_VGA_COMPATIBLE 
   StringTrimLeft, result, result, 1 
   return, result 
} 

DecodeInteger( p_type, p_address, p_offset, p_hex=true ) 
{ 
   old_FormatInteger := A_FormatInteger 
   if ( p_hex ) 
      SetFormat, Integer, hex 
   else 
      SetFormat, Integer, dec 
   sign := InStr( p_type, "u", false )^1 
   StringRight, size, p_type, 1 
   loop, %size% 
      value += ( *( ( p_address+p_offset )+( A_Index-1 ) ) << ( 8*( A_Index-1 ) ) ) 
   if ( sign and size <= 4 and *( p_address+p_offset+( size-1 ) ) & 0x80 ) 
      value := -( ( ~value+1 ) & ( ( 2**( 8*size ) )-1 ) ) 
   SetFormat, Integer, %old_FormatInteger% 
   return, value 
} 

 

struct_ReadString( byref r_struct, p_offset, p_length ) 
{ 
   loop, %p_length% 
   { 
      char := Chr( *( &r_struct+p_offset+A_Index-1 ) ) 
      if char= 
         break 
      string := string char 
   } 
   return, string 
}
/*