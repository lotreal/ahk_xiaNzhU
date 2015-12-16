; provided by: antonyb
; Function written by Invalid User
GetBattLife(Param)
{
	VarSetCapacity(powerstatus, 1+1+1+1+4+4) 
	success := DllCall("kernel32.dll\GetSystemPowerStatus", "uint", &powerstatus) 
	acLineStatus:=ReadInteger(&powerstatus,0,1,false) 
	batteryFlag:=ReadInteger(&powerstatus,1,1,false) 
	batteryLifePercent:=ReadInteger(&powerstatus,2,1,false) 
	batteryLifeTime:=ReadInteger(&powerstatus,4,4,false) 
	batteryFullLifeTime:=ReadInteger(&powerstatus,8,4,false) 
	If Param = LineStatus
		Result := acLineStatus 
	If Param = Flag
		Result := batteryFlag 
	If Param = Percent
		Result := batteryLifePercent
	If Param = LifeTime
		Result := batteryLifeTime 
	If Param = FullLifeTime
		Result := batteryFullLifeTime
	If Result =
		Result = Error - %Success%
	Return %Result%	
}
Return

ReadInteger( p_address, p_offset, p_size, p_hex=true ) 
{ 
  value = 0 
  old_FormatInteger := a_FormatInteger 
  if ( p_hex ) 
    SetFormat, integer, hex 
  else 
    SetFormat, integer, dec 
  loop, %p_size% 
    value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) ) 
  SetFormat, integer, %old_FormatInteger% 
  return, value 
} 