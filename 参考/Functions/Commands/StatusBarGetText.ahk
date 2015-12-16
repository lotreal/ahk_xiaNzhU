StatusBarGetText(Part="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   StatusBarGetText, OutputVar, % Part, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}