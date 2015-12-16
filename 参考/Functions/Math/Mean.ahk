;Returns Average values in comma delimited list
Mean(List)
{
	Loop, Parse, List , `,
	{
		Total += %A_LoopField%
		D = %A_Index%
	}
	R := Total/D
	Return R
}