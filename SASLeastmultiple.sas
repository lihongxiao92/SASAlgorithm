/**********************************************************************************************************
 * Macro Name        : Least common multiple                                                                                 
 * Purpose           : Least common multiple.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 10, 8 ====> 40
 *						
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%let n1 = 10;
%let n2 = 8;

data _null_;
	if &n1. > 0 and &n2. > 0 then do;
		if &n1. >= &n2. then nn = &n1.;
		else nn = &n2.;	
		do while(mod(nn, &n1.) ne 0 or mod(nn, &n2.) ne 0);
			nn + 1;
		end;
		put nn " is least common multiple of &n1., &n2.";
	end;
	else do;
		put "&n1., &n2." "has no least common multiple.";
	end;
	stop;	
run;

%Macro Least(n1 = , n2 =);
	
	%if &n1. > 0 and &n2. > 0 %then %do;
		%local MaxN MinN I;
		%if &n1. >= &n2. %then %do;
			%let MaxN = &n1.;
			%let MinN = &n2.;
		%end;
		%else %do;
			%let MaxN = &n2.;
			%let MinN = &n1.;
		%end;
		%let I = &MaxN.;
		%do %while(%sysfunc(mod(&I.,&MinN.)) ne 0);		
			%let I = %sysevalf(&I. + &MaxN.);		
		%end;
		%put &I. is least common multiple of &n1., &n2.;
	%end;
	%else %do;
		%put &n1., &n2.has no least common multiple.;
	%end;
	
%Mend Least;
%Least(n1 = 8, n2 = 10)

