/**********************************************************************************************************
 * Macro Name        : Armstrong number                                                                                
 * Purpose           : Armstrong number.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Feb-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 3**3 + 7**3 + 1**3 = 371
 *						1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

%let Armstrong = 407;

data _null_;
	if &Armstrong. > 0 then do;
		retain SumSplit 0;
		NArmstrong = length(cats(&Armstrong.));
		Armstrong = &Armstrong.;		
		do while(Armstrong > 0);
			SumSplit + (mod(Armstrong, 10)**NArmstrong);			
			Armstrong = int(Armstrong/10);						
		end;	
		if SumSplit = &Armstrong. then do;
			put "&Armstrong. is an armstrong number.";		
		end;
		else do;
			put "&Armstrong. is not an armstrong number.";
		end;
	end;
	else do;
		put "This program is just for positive integer.";
	end;
run;
