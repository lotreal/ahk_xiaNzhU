;Even or odd function, Returns 0 if Number is Even, 1 if Number is odd
EvenOdd(N)
{
	R := N / 2
	StringSplit, B, R, .
	StringLeft, C, B2, 1
	If C = 0
		Result = 0
	Else
		Result = 1
	Return Result
}