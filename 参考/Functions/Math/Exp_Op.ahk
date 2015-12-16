; Returns 0 If not one of the following formats:
; 1) (A/B)^N Or C(A/B)^N	Ex: (1/2)^4 Or 12(12/16)^4
; 2) Ab^N Or A^N			Ex: 2x^4 Or 2^4
; Returns 1 if true of the first
; Returns 2 if true of the second
; Note:A number must not contain two exponents 
; For example 12(2^4)^2 would return 0
; For such a number, compute the value of the number
IsExp(N)
{
	If N Contains ^
	{
		StringSplit, N, N, ^
		If N0 = 2
		{
			If N1 Contains (,)
			{
				StringSplit, F, N1, /
				If F0 = 2
					If F1 Contains (
						If F1 Not Contains )
							If F2 Contains )
								If F2 Not Contains (
									Return "1"
			}
			Return "2"
		}
	}
	Return "0"
}
