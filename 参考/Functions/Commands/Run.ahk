Run(Target, WorkingDir="", Mode="") 
{ 
   Run, % Target, % WorkingDir, % Mode, OutputVar 
   Return OutputVar    
}