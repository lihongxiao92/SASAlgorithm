/**********************************************************************************************************
 * Macro Name        : Selection Sort                                                                                 
 * Purpose           : Selection Sort .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 98, 58, 23, 100, 3, 7
 *						
 *					one loop:
 *
 *                   3, 58, 23, 100, 98, 7	
 *			         	   
 *					two loop:
 *
 *                   3, 7, 23, 100, 98, 58							 	
 *                      
 *					three loop:
 *
 *                   3, 7, 23, 100, 98, 58		
 * 
 *					four loop:
 *
 *                   3, 7, 23, 58, 98, 100				    
 *
 *					five loop:
 *
 *                   3, 7, 23, 58, 98, 100		
 **********************************************************************************************************/
 
%let  SelectSort = %bquote(98, 58, 23, 100, 3, 7);
%let  Cnt        = %sysfunc(countw(&SelectSort.));

data _null_;
	array SelectST [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		SelectST[k] = input(scan("&SelectSort.", k, ","), best.);		
	end;
	length SelectSort $30000;
	do i = 1 to (&Cnt. - 1);	
		SelectSort = "";
		put i " loop :"	;		
		SelectMin = i;
		do j = (i+1) to &Cnt.;
			if SelectST[SelectMin] > SelectST[j] then do;
				SelectMin   = j;							
			end;
		end;
		TempVar = SelectST[SelectMin];
		SelectST[SelectMin] = SelectST[i];
		SelectST[i] = TempVar;	
		do l = 1 to &Cnt.;
			SelectSort = catx(" , ", SelectSort, SelectST[l]);
		end;
		put SelectSort;
	end;
	stop;
run;
