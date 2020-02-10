/**********************************************************************************************************
 * Macro Name        : Fibonacci sequence                                                                                
 * Purpose           : Fibonacci sequence.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : n3 = n2 + n1 
 *						0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%let Fibonacci = 10;

data _null_ ;
	if &Fibonacci. = 1 then do;
		n1 = 0;
		put "&Fibonacci. Fibonacci sequence is " n1; 
	end;
	else if &Fibonacci. = 2 then do;
		n1 = 0;
		n2 = 1;
		put "&Fibonacci. Fibonacci sequence is " n1 " " n2; 
	end;
	else do;
		array Fib [&Fibonacci.] _temporary_ ;
		Fib[1] = 0;
		Fib[2] = 1;
		put "&Fibonacci. Fibonacci sequence is:";
		put Fib[1];
		put Fib[2];
		do i = 3 to &Fibonacci.;
			Fib[i] = Fib[i-1] + Fib[i-2];
			put Fib[i];
		end;
	end;	
	drop i;
	stop;
run;

%Macro Fibonacci(Fibonacci = );

	%if &Fibonacci. = 1 %then %do;
		%local n1;
		%let n1 = 0;
		%put &Fibonacci. Fibonacci sequence is  &n1.; 
	%end;
	%else %if &Fibonacci. = 2 %then %do;
		%local n1 n2;
		%let n1 = 0;
		%let n2 = 1;
		%put &Fibonacci. Fibonacci sequence is &n1. &n2.; 
	%end;
	%else %do;
		%local n1 n2 nn;
		%let n1 = 0;
		%let n2 = 1;
		%put;
		%put &Fibonacci. Fibonacci sequence is:;
		%put &n1.;
		%put &n2.; 
		%do i = 3 %to &Fibonacci.;
			%let nn = %eval(&n1. + &n2.);
			%put &nn.;
			%let n1 = &n2.;
			%let n2 = &nn.;
		%end;
		%put;
	%end;
%Mend Fibonacci;
%Fibonacci(Fibonacci = 10)
