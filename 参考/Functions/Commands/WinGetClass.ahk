WinGetClass(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetClass, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}