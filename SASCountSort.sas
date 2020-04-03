/**********************************************************************************************************
 * Macro Name        : Count Sort                                                                                 
 * Purpose           : Count Sort .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 59,57 ,46, 98, 58, 23, 100, 3, 7, 8
 *						
 *				
 *
 *              
 *			    
 *				
 *
 *              					 	
 *              
 *				
 *
 *              
 * 
 *				
 *
 *              		    
 *
 *				
 *
 *              
 **********************************************************************************************************/
 
%let  CountSort = %bquote(59,57 ,46, 98, 58, 23, 100, 3, 7, 8);
%let  Cnt       = %sysfunc(countw(&CountSort.));

data _null_;
	array CountST [&Cnt.] _temporary_;
	do k = 1 to &Cnt.;
		CountST[k] = input(scan("&CountSort.", k, ","), best.);		
	end;
	/* Get the Max number */
	/* Using macro */
	
	%macro GetMaxNumber;
		%Global TempMax;
		%let TempMax = %scan(&CountSort., 1, %str(,));	
		%do k = 2 %to &Cnt.;			
			%if &TempMax. < %scan(&CountSort., &k., %str(,)) %then %do;
				%let TempMax = %scan(&CountSort., &k., %str(,));
			%end;			
		%end;		
	%Mend GetMaxNumber;
	%GetMaxNumber
	
	/* Decalre a new array and count every element. */
	array Count999 [&TempMax.] _temporary_;
	do i = 1 to &Cnt.;
		Count999[CountST[i]] + 1;
	end;
	/* Output the new sorted array */
	Index = 1;
	do j = 1 to &TempMax.;	
		do while(Count999[j] > 0);
			CountST[Index] = j;
			Index + 1;
			Count999[j] = Count999[j] - 1;
		end;
	end;
	
	length CountSort $30000;
	do l = 1 to &Cnt.;
		CountSort = catx(" , ", CountSort, CountST[l]);
	end;
	put CountSort;
run;

