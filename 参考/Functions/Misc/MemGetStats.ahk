                                                                                                                    
MemGetStats()                                                                                                         
{                                                                                                                     
  ; See:                                                                                                              
  ; http://msdn.microsoft.com/library/default.asp?url=/library/en-us/memory/base/memorystatus_str.asp                 
                                                                                                                      
  VarSetCapacity(memorystatus, 4+4+4+4+4+4+4+4)                                                                       
  success := DllCall("kernel32.dll\GlobalMemoryStatus", "uint", &memorystatus)                                        
  stats := ReadInteger(&memorystatus,4,4, false)                          ; Memory Load (Percentage of memory in use) 
  stats := stats "|" Round(ReadInteger(&memorystatus,8,4, false)/1024)    ; Total Physical Ram                        
  stats := stats "|" Round(ReadInteger(&memorystatus,12,4, false)/1024)   ; Available Physical Ram                    
  stats := stats "|" Round(ReadInteger(&memorystatus,16,4, false)/1024)   ; Total Pagefile                            
  stats := stats "|" Round(ReadInteger(&memorystatus,20,4, false)/1024)   ; Available Pagefile                        
  stats := stats "|" Round(ReadInteger(&memorystatus,24,4, false)/1024)   ; Total Virtual                             
  stats := stats "|" Round(ReadInteger(&memorystatus,28,4, false)/1024)   ; Available Virtual                         
  return stats                                                                                                        
}                                                                                                                     
                                                                                                                      
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