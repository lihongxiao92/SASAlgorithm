/**********************************************************************************************************
 * Macro Name        : Hanoi                                                                                
 * Purpose           : Hanoi.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Apr-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : n3 = n2 + n1 
 *						0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%Macro CallHanoi(N, A, B, C);

	%macro MoveHanoi(I, F, T);
		%put &I. Hanoi from &F. to &T.;
	%mend MoveHanoi;
	
	%Macro Hanoi(N, A, B, C);
		/* GoupStairs stop condition */
		%if %eval(&N. <= 1) %then %do;
			%MoveHanoi(&N., &A., &C.)
			%return;
		%end;
		
		%Hanoi(%eval(&N. - 1), &A., &C., &B.)
		%MoveHanoi(&N., &A., &C.)
		%Hanoi(%eval(&N. - 1), &B., &A., &C.)
		
	%Mend Hanoi;
	
	%Hanoi(&N., &A., &B., &C.)
%Mend CallHanoi;

%CallHanoi(5, A, B, C)

