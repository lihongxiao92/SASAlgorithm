/**********************************************************************************************************
 * Macro Name        : Calculator                                                                                
 * Purpose           : Calculator.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : +-*%/
 *						
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%Macro Calculator(N1 =, N2 =, Mode =);
	
	%if &Mode. ne %str(%%) %then %do;		
		%put &N1. &Mode. &N2. is %sysevalf(%unquote(&N1. &Mode. &N2.));
	%end;
	%else %do;
		%put &N1. &Mode. &N2. is %sysfunc(mod(&N1., &N2.));
	%end;
	
%Mend Calculator;
%Calculator(N1 = 3, N2 = 3, Mode = %str(%%))
%Calculator(N1 = 3, N2 = 3, Mode = %str(+))
%Calculator(N1 = 3, N2 = 3, Mode = %str(-))
%Calculator(N1 = 3, N2 = 3, Mode = %str(*))
%Calculator(N1 = 3, N2 = 3, Mode = %str(/))
