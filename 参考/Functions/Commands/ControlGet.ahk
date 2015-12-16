ControlGet(Cmd, Value="", Control="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGet, OutputVar, % Cmd, % Value, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}