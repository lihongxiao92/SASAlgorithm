/**********************************************************************************************************
 * Macro Name        : Factorial operation                                                                                
 * Purpose           : Factorial operation.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 5! = 5*4*3*2*1
 *						
 *                     
 *				                       
 *                                                                         
 **********************************************************************************************************/

%let Factorial = 5;

data _null_;
	retain Factorial 1;
	if &Factorial. < 0 then do;
		put "&Factorial. have no factorial.";
	end;
	else if &Factorial. = 0 then do;
		put "&Factorial. factorial is 1.";
	end;
	else do;
		do i = 1 to &Factorial.;
			Factorial = (Factorial*i);
		end;
		put "&Factorial. factorial is " Factorial ".";
	end;
	drop i;
	stop;
run;

%Macro CallFactorial(N = );

	%Macro Factorial(Factorial = );

		%if &Factorial. < 0 %then %do;
			%put &Factorial. has no Factorial.;
			%return;
		%end;
		%else %if &Factorial. = 0 %then %do;
			%put &Factorial. factorial is 1.;
			%return;
		%end;
		%else %if &Factorial. = 1 %then %do;
			1	
			%return;
		%end;
		%else %if &Factorial. > 1 %then %do;
			%eval(&Factorial.* %Factorial(Factorial = %eval(&Factorial.-1))
		%end;		
	
	%Mend Factorial;
	
 %put &N. factorial is %Factorial(Factorial = &N.);

%Mend CallFactorial;

%CallFactorial(N = 5)
