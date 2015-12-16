InputBox(Title="", Prompt="", HIDE="", Width="", Height="", X="", Y="", Font="", Timeout="", Default="") 
{ 
   InputBox, OutputVar, % Title, % Prompt, % HIDE, % Width, % Height, % X, % Y, , % Timeout, % Default 
   Return OutputVar 
}