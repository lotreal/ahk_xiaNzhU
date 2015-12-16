;**** Function LeapYear(In_Year) 
;**** Checks if a year (format YYYY) is a leap year 
;**** Returns 1 if yes, else 0, -1 if wrong format 
LeapYear(In_Year) 
{ 
  local len, t4, t100, t400 
  StringLen, len, In_Year 
  if (len<>4) 
     return -1 
  T4:=Mod(In_Year,4) 
  T100:=Mod(In_Year,100) 
  T400:=Mod(In_Year,400) 
  if (T4=0) AND (((T100=0)and(T400=0)) or (T100<>0)) 
       return, 1 
  else 
       return 0 
}