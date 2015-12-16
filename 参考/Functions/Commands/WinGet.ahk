WinGet(Cmd="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGet, OutputVar, % Cmd, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}