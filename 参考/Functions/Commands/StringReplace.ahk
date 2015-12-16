StringReplace(InputVar, SearchText, ReplaceText="", All="") 
{ 
   StringReplace, OutputVar, %InputVar%, % SearchText, % ReplaceText, % All 
   Return OutputVar 
}