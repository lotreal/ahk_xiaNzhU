ControlGetFocus(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGetFocus, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}