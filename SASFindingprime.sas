/**********************************************************************************************************
 * Macro Name        : Finding prime numbers                                                                                
 * Purpose           : Finding prime numbers.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 09-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : A prime number (or a prime) is a natural number greater than 1 that cannot be formed 
 *						by multiplying two smaller natural numbers.
 *                      2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 
 *				        41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97                
 *                                                                         
 **********************************************************************************************************/


%let LowerPrime = 1;
%let UpperPrime = 50;

data _null_;		
	if &LowerPrime. >= 1 and &UpperPrime. >= &LowerPrime. then do;		
		do i = &LowerPrime. to &UpperPrime.;
			if i > 1 then do;
				PrimeFlag = 1;
				do j = 2 to ceil((i - 1)/2);;
					if mod(i, j) = 0 then do;						
						PrimeFlag = 0;
						leave;
					end;			
				end;
				if PrimeFlag = 1 then do;
					put i "is a prime number.";
				end;
			end;
		end;		
	end;
	else do;
		put "&LowerPrime -- &UpperPrime. have no prime number.";
	end;
	stop;
run;

%Macro FindPrime(LowerPrime =, UpperPrime =);
	%local i PrimeFlag;
	%if &LowerPrime. >= 1 and &UpperPrime. >= &LowerPrime. %then %do;
		%do i = &LowerPrime. %to &UpperPrime.;
			%if &i. > 1 %then %do;
				%let PrimeFlag = 1;
				%do j = 2 %to %sysfunc(ceil(%sysevalf((&i. -1)/2)));
					%if %sysfunc(mod(&i., &j.)) = 0 %then %do;
						%let PrimeFlag = 0;						
					%end;
				%end;
				%if &PrimeFlag. = 1 %then %do;		
					%put &i. is a prime number.;
				%end;
			%end;
		%end;
	%end;
	%else %do;
		%put &LowerPrime -- &UpperPrime. have no prime number.;
	%end;	
%Mend FindPrime;
%FindPrime(LowerPrime = 1, UpperPrime = 100);
 
