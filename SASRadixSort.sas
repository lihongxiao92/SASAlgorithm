/**********************************************************************************************************
 * Macro Name        : Radix Sort                                                                                 
 * Purpose           : Radix Sort .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 57 ,46, 98, 58, 23, 100, 3, 7, 8s
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

%let  RadixSort = %bquote(2, 57 ,46, 98, 58, 23, 100, 3, 7, 8);
%let  Cnt       = %sysfunc(Countw(&RadixSort.));

data _null_;
	array RadixST [&Cnt.] _temporary_;
	do k = 1 to &Cnt.;
		RadixST[k] = input(scan("&RadixSort.", k, ","), best.);		
	end;
	/* Get the Max number */
	/* Using macro */
	
	%Macro GetMaxNumber;
		%Global TempMax;
		%let TempMax = %scan(&RadixSort., 1, %str(,));	
		%do k = 2 %to &Cnt.;			
			%if &TempMax. < %scan(&RadixSort., &k., %str(,)) %then %do;
				%let TempMax = %scan(&RadixSort., &k., %str(,));
			%end;			
		%end;		
	%Mend GetMaxNumber;
	%GetMaxNumber
	
	D = 1;
	do while(D <= &TempMax.);
		/* Declare a new array and Radix every element. */
		array Radix999 [0:9] _temporary_;
		do i = 0 to 9;
			Radix999[i] = 0;
		end;
		
		do i = 1 to &Cnt.;
			x = mod(int(RadixST[i]/D), 10);
			Radix999[mod(int(RadixST[i]/D), 10)] + 1;
		end;
		
		do i = 1 to 9;
			Radix999[i] = Radix999[i -1] + Radix999[i];
		end;
		
		/* Output the new sorted array */
		array RadixSTT [&Cnt.] _temporary_;
		do j = &Cnt. to 1 by -1;								
			RadixSTT[Radix999[mod(int(RadixST[j]/D), 10)]] = RadixST[j];		
			Radix999[mod(int(RadixST[j]/D), 10)] = Radix999[mod(int(RadixST[j]/D), 10)] - 1;		
		end;

		do j = 1 to &Cnt.;	
			RadixST[j] = RadixSTT[j];
		end;
		D = D*10;
	end;
	
	length RadixSort $30000;
	do l = 1 to &Cnt.;
		RadixSort = catx(" , ", RadixSort, RadixST[l]);
	end;
	put RadixSort;
run;
