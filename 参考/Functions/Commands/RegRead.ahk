RegRead(RootKey, SubKey, ValueName="") 
{ 
   RegRead, OutputVar, % RootKey, % SubKey, % ValueName 
   Return OutputVar 
}