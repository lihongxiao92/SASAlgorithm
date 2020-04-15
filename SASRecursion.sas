/**********************************************************************************************************
 * Macro Name        : Recursion                                                                                
 * Purpose           : Recursion.                                      
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

/* Cumulative summation 1 */

%Macro CallRecursionCnt(N);

	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 1) %then %do;
			1
			%return;
		%end;	
		%local Cnt NT CnTT;
		%let NT = %eval(&N. - 1);
		%let CnTT = %RecursionCnt(&NT.);
		%let Cnt = %eval(&N. + &CnTT.);
		&Cnt.
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(100)


/* Cumulative summation 2 */

%Macro CallRecursionCnt(N);

	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 1) %then %do;
			1
			%return;
		%end;	
		
		%eval(&N.*(&N.+ 1)/2)
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(100)

/* Cumulative summation 3 */

%Macro CallRecursionCnt(N);

	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%local i Cnt;
		%let Cnt =;
		%do i = 1 %to &N.;
			%let Cnt = %eval(&Cnt. + &i.);
		%end;
		%ReturnValue: &Cnt.
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(100)

/* Fibonacci sequence  */

%Macro CallRecursionCnt(N);

	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 2) %then %do;
			&N.
			%return;
		%end;
		%local Cnt1 Cnt2;
		
		%let Cnt1 = %RecursionCnt(%eval(&N. - 1)) ;
		%let Cnt2 = %RecursionCnt(%eval(&N. - 2)) ;
		%eval(&Cnt1. + &Cnt2.)
		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)

/* Improving the algorithm - 1 using array to save the value.*/

%Macro CallRecursionCnt(N);

	%local i;	
	%do i = 1 %to &N.;
		%local RecursionCnt&I.;
		%if &i. <= 2 %then %do;
			%let RecursionCnt&I. = 1;
		%end;
		%else %do;
			%let RecursionCnt&I. = ;
		%end;
	%end;
	
	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 2) %then %do;
			&N.
			%return;
		%end;
		%local Cnt1 Cnt2;		
		%if %length(&&RecursionCnt&N..) = 0 %then %do;
			%let Cnt1 = %eval(&N. - 1);
			%let Cnt2 = %eval(&N. - 2);
			%let RecursionCnt&N. = %eval(%RecursionCnt(&Cnt1.) + %RecursionCnt(&Cnt2.));
		%end;
		
		&&RecursionCnt&N..
		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)


/* Improving the algorithm - 2 using array to replace the Recursion.*/

%Macro CallRecursionCnt(N);

	%local i;	
	%do i = 1 %to &N.;
		%local RecursionCnt&I.;
		%if &i. <= 2 %then %do;
			%let RecursionCnt&I. = 1;
		%end;
		%else %do;
			%let RecursionCnt&I. = ;
		%end;
	%end;
	
	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 2) %then %do;
			1
			%return;
		%end;
		%local i;
		%do i = 3 %to &N.;
			%let Cnt1 = %eval(&i. - 1);
			%let Cnt2 = %eval(&i. - 2);
			%let RecursionCnt&i. = %eval(&&RecursionCnt&Cnt1.. + &&RecursionCnt&Cnt2..);
		%end;		
		&&RecursionCnt&N..
		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)

/* Improving the algorithm - 3 using scrolling array to replace the array.*/

%Macro CallRecursionCnt(N);

	%local i;	
	%do i = 1 %to &N.;
		%local RecursionCnt&I.;
		%if &i. <= 2 %then %do;
			%let RecursionCnt&I. = 1;
		%end;
		%else %do;
			%let RecursionCnt&I. = ;
		%end;
	%end;
	
	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 2) %then %do;
			1
			%return;
		%end;
		%local i;
		%do i = 3 %to &N.;
			%local CntMod1 CntMod2 CntMod;
			%let CntMod =  %eval(1 + %sysfunc(mod(&i., 2)));			
			%let CntMod1 = %eval(1 + %sysfunc(mod(%eval(&i. - 1), 2)));
			%let CntMod2 = %eval(1 + %sysfunc(mod(%eval(&i. - 2), 2)));
			%let RecursionCnt&CntMod. = %eval(&&RecursionCnt&CntMod1.. + &&RecursionCnt&CntMod2..);
		%end;		
		&&RecursionCnt&CntMod..		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)

/* Improving the algorithm - 4 using Bitwise operation to replace the array.*/

/* Improving the algorithm - 5 using temporary variable to replace the array.*/

%Macro CallRecursionCnt(N);

	%local i;	
	%do i = 1 %to &N.;
		%local RecursionCnt&I.;
		%if &i. <= 2 %then %do;
			%let RecursionCnt&I. = 1;
		%end;
		%else %do;
			%let RecursionCnt&I. = ;
		%end;
	%end;
	
	%Macro RecursionCnt(N);
		/* Recursion stop condition */
		%if %eval(&N. <= 2) %then %do;
			1
			%return;
		%end;
		%local i;
		%do i = 3 %to &N.;			
			%let RecursionCnt2 = %eval(&RecursionCnt2. + &RecursionCnt1.);
			%let RecursionCnt1 = %eval(&RecursionCnt2. - &RecursionCnt1.);
		%end;		
		&RecursionCnt2.		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)

/* Recursion ----- Go up the stairs */

%Macro CallGoupStairsCnt(N);

	%Macro GoupStairsCnt(N);
		/* GoupStairs stop condition */
		%if %eval(&N. <= 2) %then %do;
			1
			%return;
		%end;
		%local Cnt1 Cnt2;
		
		%let Cnt1 = %GoupStairsCnt(%eval(&N. - 1)) ;
		%let Cnt2 = %GoupStairsCnt(%eval(&N. - 2)) ;
		%eval(&Cnt1. + &Cnt2.)
		
	%Mend GoupStairsCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %GoupStairsCnt(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallGoupStairsCnt;

%CallGoupStairsCnt(5)

/* Recursion ----- Factorial */

%Macro CallFactorial(N);

	%Macro Factorial(N);
		
		%if %eval(&N. <= 1) %then %do;
			1
			%return;
		%end;
		
		%eval(&N. * %Factorial(%eval(&N. - 1)))
		
	%Mend Factorial;
	
	%put;
	%put =====================;
	%put;
	%put Factorial &N.;
	%put %Factorial(&N.);	
	%put;
	%put =====================;
	%put;
	
%Mend CallFactorial;

%CallFactorial(5)


/* Recursion ----- Factorial Tail recursion Optimization */


%Macro CallTailFactorial(N);

	%let ReturnValueG = 1;
	
	%Macro TailFactorial(N , ReturnValue);
		
		%if %eval(&N. <= 1) %then %do;
			&ReturnValue.			
			%return;
		%end;
		
		%TailFactorial(%eval(&N.-1), %eval(&N.*&ReturnValue.))
		
	%Mend TailFactorial;
	
	%put;
	%put =====================;
	%put;
	%put TailFactorial &N.;
	%put %TailFactorial(&N., &ReturnValueG.);		
	%put;
	%put =====================;
	%put;
	
%Mend CallTailFactorial;

%CallTailFactorial(5)


/* Recursion ----- Factorial Tail recursion Optimization */


%Macro CallTailFactorial(N);

	%let ReturnValueG = 1;
	
	%Macro TailFactorial(N , ReturnValue);
		
		%if %eval(&N. <= 1) %then %do;
			&ReturnValue.			
			%return;
		%end;
		
		%TailFactorial(%eval(&N.-1), %eval(&N.*&ReturnValue.))
		
	%Mend TailFactorial;
	
	%put;
	%put =====================;
	%put;
	%put TailFactorial &N.;
	%put %TailFactorial(&N., &ReturnValueG.);		
	%put;
	%put =====================;
	%put;
	
%Mend CallTailFactorial;

%CallTailFactorial(5)

/* Tail Recursion ----- Fibonacci sequence  */

%Macro CallRecursionCnt(N);
	
	%Macro RecursionCnt(N, F, S);
		/* Recursion stop condition */
		%if %eval(&N. <= 1) %then %do;
			&S.
			%return;
		%end;

		%RecursionCnt(%eval(&N. - 1), &S., %eval(&F. + &S.))
		
	%Mend RecursionCnt;
	
	%put;
	%put =====================;
	%put;
	%put Cumulative summation &N.;
	%put %RecursionCnt(&N., 1, 1);	
	%put;
	%put =====================;
	%put;
	
%Mend CallRecursionCnt;

%CallRecursionCnt(5)
