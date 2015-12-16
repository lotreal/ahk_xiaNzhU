; Program: Format Date Function 
; Author: beardboy 
; Version: 00 
; Last Modified: 2005.05.18 
; Last Changes: First Version 

/* 
types 
1 = 20050415 
2 = 04/15/05 or 04/15/2005 
3 = Apr-15-05 or Apr-15-2005 
4 = 15-04-05 or 15-04-2005 

example 
date := FormatDate("01/05/1999",2,"dddd MMMM dd yyyy") 
MsgBox, %date% 
ExitApp 
*/ 

FormatDate(date,intype,outtype) 
{ 
  if intype = 1 ; 20050415 
  { 
    if date <> 
      FormatTime, date, %date%, %outtype% 
  } 
  else if intype = 2 ; 04/15/05 or 04/15/2005 
  { 
    StringLeft, month, date, 2 
    StringMid, day, date, 4, 2 
    StringMid, year, date, 7, 4 
    year := FormatYear(year) 
    FormatTime, date, %year%%month%%day%, %outtype% 
  } 
  else if intype = 3 ; Apr-15-05 or Apr-15-2005 
  { 
    months = Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec 
    StringLeft, month, date, 3 
    StringMid, day, date, 5, 2 
    StringMid, year, date, 8, 4 
    Loop, Parse, months, `, 
    { 
      if a_loopfield = %month% 
      { 
        month = %a_index% 
        break 
      } 
    } 
    if month < 10 
      month = 0%month% 
    year := FormatYear(year) 
    FormatTime, date, %year%%month%%day%, %outtype% 
  } 
  else if intype = 4 ; 15-04-05 or 15-04-2005 
  { 
    StringLeft, day, date, 2 
    StringMid, month, date, 4, 2 
    StringMid, year, date, 7, 4 
    year := FormatYear(year) 
    FormatTime, date, %year%%month%%day%, %outtype% 
  } 
  return date 
}

;Used in conjuction with FormatDate function.
FormatYear(year) 
{ 
  StringLen, length, year 
  if length = 2 
  { 
    if year > 30 
      year = 19%year% 
    else 
      year = 20%year% 
  } 
  return year 
}