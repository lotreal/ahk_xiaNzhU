;**** Function GetRelPos(...parameters see below.....) 
;**** In_X,In_Y = Position of the Startpoint 
;**** In_Angle = Angle from In_X,In_Y to Targetpoint (0..360) 
;**** 0,360 are NORTH 
;**** In_Radius = Distance from In_X,In_Y to Targetpoint 
;**** Tx,Ty = Returns the Position of the Targetpoint 
;**** Function was done by Laszlo because I am a Math-Idiot 
GetRelPos(In_X,In_Y,In_Angle,In_Radius,Byref Tx, Byref Ty) 
{ 
   Transform SinVal, Sin, In_Angle*0.01745329252 
   Transform CosVal, Cos, In_Angle*0.01745329252 
   Tx := In_X - SinVal*In_Radius 
   Ty := In_Y + CosVal*In_Radius 
}