GuiControlGet(Subcommand="", ControlID="", Param4="") 
{ 
   GuiControlGet, OutputVar, % Subcommand, % ControlID, % Param4 
   Return OutputVar 
}