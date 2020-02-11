/**********************************************************************************************************
 * Macro Name        : Greatest common divisor                                                                                
 * Purpose           : Greatest common divisor.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 56, 30 ====> 6
 *						
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%let n1 = 54;
%let n2 = 30;

data _null_;
	if &n1. > 0 and &n2. > 0 then do;
		if &n1. <= &n2. then nn = &n1.;
		else nn = &n2.;	
		retain divisor 0;
		do i = 2 to nn;
			if mod(&n1., i) = 0 and mod(&n2., i) = 0 then do;
				divisor = i;			
			end;
		end;
		if divisor ne 0 then do;
			put divisor " is greatest common divisor of &n1., &n2.";
		end;
		else do;
			put "&n1., &n2." "has no greatest common divisor.";
		end;
	end;
	else do;
		put "&n1., &n2." "has no greatest common divisor.";
	end;
	stop;	
run;

