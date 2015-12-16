;*****returns path of default browser so you can open links in new windows
;*****(with the system's default browser ofcourse). 


Web() 
{ 
   RegRead, htmlOpenPath, HKCR, htmlfile\shell\open\command 
   Return, %htmlOpenPath% 
}