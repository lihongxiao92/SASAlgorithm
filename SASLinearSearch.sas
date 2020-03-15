/**********************************************************************************************************
 * Macro Name        : Linear Search                                                                                 
 * Purpose           : Linear Search .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 3, 7, 23, 58, 98, 100
 *						Search the index of 98
 *                         
 *					one loop:
 *
 *					two loop:
 *
 *                   					 	
 **********************************************************************************************************/

%let  LinearSearch = %bquote(3, 7, 23, 58, 98, 100);
%let  Cnt          = %sysfunc(countw(&LinearSearch.));
%let  Target       = 58;

data _null_;
	array LinearSH [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		LinearSH[k] = input(scan("&LinearSearch.", k, ","), best.);		
	end;	
	Target     = &Target.;	
	do Index = 1 to &Cnt.;
		if LinearSH[Index] = Target then do;
			put Target " index is " Index;	
			leave;
		end;
	end;
	stop;
run;
