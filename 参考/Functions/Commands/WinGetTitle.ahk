WinGetTitle(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetTitle, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}