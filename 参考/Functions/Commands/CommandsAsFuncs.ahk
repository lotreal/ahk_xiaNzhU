ControlGet(Cmd, Value="", Control="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGet, OutputVar, % Cmd, % Value, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
ControlGetFocus(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGetFocus, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
ControlGetText(Control="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   ControlGetText, OutputVar, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
DriveGet(Cmd, Value="") 
{ 
   DriveGet, OutputVar, % Cmd, % Value 
   Return OutputVar 
} 
DriveSpaceFree(Path) 
{ 
   DriveSpaceFree, OutputVar, % Path 
   Return OutputVar 
} 
FileGetAttrib(Filename) 
{ 
   FileGetAttrib, OutputVar, % Filename 
   Return OutputVar 
} 
FileGetSize(Filename="", Units="") 
{ 
   FileGetSize, OutputVar, % Filename, % Units 
   Return OutputVar 
} 
FileGetTime(Filename="", WhichTime="") 
{ 
   FileGetTime, OutputVar, % Filename, % WhichTime 
   Return OutputVar 
} 
FileGetVersion(Filename) 
{ 
   FileGetVersion, OutputVar, % Filename 
   Return OutputVar 
} 
FileRead(Filename) 
{ 
   FileRead, OutputVar, % Filename 
   Return OutputVar 
} 
FileReadLine(Filename, LineNum) 
{ 
   FileReadLine, OutputVar, % Filename, % LineNum 
   Return OutputVar 
} 
FileSelectFile(Options="", RootDir="", Prompt="", Filter="") 
{ 
   FileSelectFile, OutputVar, % Options, % RootDir, % Prompt, % Filter 
   Return OutputVar 
} 
FileSelectFolder(RootDir="", Options="", Prompt="") 
{ 
   FileSelectFolder, OutputVar, % RootDir, % Options, % Prompt 
   Return OutputVar 
} 
FormatTime(YYYYMMDDHH24MISS="", Format="") 
{ 
   FormatTime, OutputVar, % YYYYMMDDHH24MISS, % Format 
   Return OutputVar 
} 
GetKeyState(WhichKey , Mode="") 
{ 
   GetKeyState, OutputVar, % WhichKey, % Mode 
   Return OutputVar 
} 
GuiControlGet(Subcommand="", ControlID="", Param4="") 
{ 
   GuiControlGet, OutputVar, % Subcommand, % ControlID, % Param4 
   Return OutputVar 
} 
ImageSearch_X(X1, Y1, X2, Y2, ImageFile) 
{ 
   ImageSearch, OutputVar, , % X1, % Y1, % X2, % Y2, % ImageFile 
   Return OutputVar 
} 
ImageSearch_Y(X1, Y1, X2, Y2, ImageFile) 
{ 
   ImageSearch, , OutputVar, % X1, % Y1, % X2, % Y2, % ImageFile 
   Return OutputVar 
} 
IniRead(OutputVar, Filename, Section, Key, Default="") 
{ 
   IniRead, OutputVar, % Filename, % Section, % Key, % Default 
   Return OutputVar 
} 
Input(Options="", EndKeys="", MatchList="") 
{ 
   Input, OutputVar, % Options, % EndKeys, % MatchList 
   Return OutputVar 
} 
InputBox(Title="", Prompt="", HIDE="", Width="", Height="", X="", Y="", Font="", Timeout="", Default="") 
{ 
   InputBox, OutputVar, % Title, % Prompt, % HIDE, % Width, % Height, % X, % Y, , % Timeout, % Default 
   Return OutputVar 
} 
MouseGetPos_X() 
{ 
   MouseGetPos, OutputVar 
   Return OutputVar 
} 
MouseGetPos_Y() 
{ 
   MouseGetPos, , OutputVar 
   Return OutputVar 
} 
MouseGetPos_Win() 
{ 
   MouseGetPos, , , OutputVar 
   Return OutputVar 
} 
MouseGetPos_Ctrl() 
{ 
   MouseGetPos, , , , OutputVar 
   Return OutputVar 
} 
PixelGetColor(X, Y , RGB="") 
{ 
   PixelGetColor, OutputVar, % X, % Y, % RGB 
   Return OutputVar 
} 
Pixelsearch_X(X1, Y1, X2, Y2, ColorID , Variation="", Mode="") 
{ 
   Pixelsearch, OutputVar, , X1, Y1, X2, Y2, ColorID , Variation, Mode 
   Return OutputVar 
} 
Pixelsearch_Y(X1, Y1, X2, Y2, ColorID , Variation="", Mode="") 
{ 
   Pixelsearch, , OutputVar, X1, Y1, X2, Y2, ColorID , Variation, Mode 
   Return OutputVar 
} 
Random(Min="", Max="") 
{ 
   Random, OutputVar, % Min, % Max 
   Return OutputVar 
} 
RegRead(RootKey, SubKey, ValueName="") 
{ 
   RegRead, OutputVar, % RootKey, % SubKey, % ValueName 
   Return OutputVar 
} 
Run(Target, WorkingDir="", Mode="") 
{ 
   Run, % Target, % WorkingDir, % Mode, OutputVar 
   Return OutputVar    
} 
SoundGet(ComponentType="", ControlType="", DeviceNumber="") 
{ 
   SoundGet, OutputVar, % ComponentType, % ControlType, % DeviceNumber 
   Return OutputVar 
} 
SoundGetWaveVolume(DeviceNumber) 
{ 
   SoundGetWaveVolume, OutputVar, % DeviceNumber 
   Return 
} 
StatusBarGetText(Part="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   StatusBarGetText, OutputVar, % Part, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
StringGetPos(InputVar, SearchText, Mode="", Offset="") 
{ 
   StringGetPos, OutputVar, %InputVar%, % SearchText, % Mode, % Offset 
   Return OutputVar 
} 
StringLeft(InputVar, Count) 
{ 
   StringLeft, OutputVar, %InputVar%, % Count 
   Return OutputVar 
} 
StringLen(InputVar) 
{ 
   StringLen, OutputVar, %InputVar% 
   Return OutputVar 
} 
StringLower(InputVar, T="") 
{ 
   StringLower, OutputVar, %InputVar%, % T 
   Return OutputVar 
} 
StringMid(InputVar, StartChar, Count , L="") 
{ 
   StringMid, OutputVar, %InputVar%, % StartChar, % Count, % L 
   Return OutputVar 
} 
StringReplace(InputVar, SearchText, ReplaceText="", All="") 
{ 
   StringReplace, OutputVar, %InputVar%, % SearchText, % ReplaceText, % All 
   Return OutputVar 
} 
StringRight(InputVar, Count) 
{ 
   StringRight, OutputVar, %InputVar%, % Count 
   Return OutputVar 
} 
StringTrimLeft(InputVar, Count) 
{ 
   StringTrimLeft, OutputVar, %InputVar%, % Count 
   Return OutputVar 
} 
StringTrimRight(InputVar, Count) 
{ 
   StringTrimRight, OutputVar, %InputVar%, % Count 
   Return OutputVar 
} 
StringUpper(InputVar, T="") 
{ 
   StringUpper, OutputVar, %InputVar%, % T 
   Return OutputVar 
} 
SysGet(Subcommand, Param3="") 
{ 
   SysGet, OutputVar, % Subcommand, % Param3 
   Return OutputVar 
} 
Transform(Cmd, Value1, Value2="") 
{ 
   Transform, OutputVar, % Cmd, % Value1, % Value2 
   Return OutputVar 
} 
WinGet(Cmd="", WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGet, OutputVar, % Cmd, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
WinGetActiveTitle() 
{ 
   WinGetActiveTitle, OutputVar 
   Return OutputVar 
} 
WinGetClass(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetClass, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
WinGetText(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetText, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
} 
WinGetTitle(WinTitle="", WinText="", ExcludeTitle="", ExcludeText="") 
{ 
   WinGetTitle, OutputVar, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText 
   Return OutputVar 
}