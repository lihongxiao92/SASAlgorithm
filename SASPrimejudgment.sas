/**********************************************************************************************************
 * Macro Name        : Prime judgment                                                                                
 * Purpose           : Prime judgment.                                      
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

%let Prime = 13;

data _null_;	
	if &Prime. > 1 then do;
		PrimeFlag = 1;
		do i = 2 to ceil((&Prime. - 1)/2);;
			if mod(&Prime., i) = 0 then do;
				put "&Prime. is not a prime number.";
				PrimeFlag = 0;
				leave;
			end;			
		end;
		if PrimeFlag = 1 then do;
			put "&Prime. is a prime number.";
		end;
	end;
	else do;
		put "&Prime. is not a prime number.";
	end;
	stop;
run;

%Macro Prime(Prime =);
	%local i PrimeFlag;
	%if &Prime. > 1 %then %do;
		%let PrimeFlag = 1;
		%do i = 2 %to %sysfunc(ceil(%sysevalf((&Prime. -1)/2)));
			%if %sysfunc(mod(&Prime., &i.)) = 0 %then %do;
				%let PrimeFlag = 0;
				%put &Prime. is not a prime number.;
			%end;
		%end;
		%if &PrimeFlag. = 1 %then %do;		
			%put &Prime. is a prime number.;
		%end;
	%end;
	%else %do;
		%put &Prime. is not a prime number.;
	%end;	
%Mend Prime;
%Prime(Prime = 5)

