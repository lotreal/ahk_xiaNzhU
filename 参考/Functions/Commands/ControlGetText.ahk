ControlGetText(Control="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGetText, OutputVar, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}