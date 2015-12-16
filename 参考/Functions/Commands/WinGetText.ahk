WinGetText(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetText, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}