/**********************************************************************************************************
 * Macro Name        : Bubble Sort                                                                                
 * Purpose           : Bubble Sort.                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 98, 58, 23, 100, 3, 7
 *						
 *					one loop:
 *
 *                   58, 98, 23, 100, 3, 7
 *					 58, 23, 98, 100, 3, 7		
 *					 58, 23, 98, 100, 3, 7		
 *			         58, 23, 98, 3, 100, 7		
 *					 58, 23, 98, 3, 7, 100			
 *			         	   
 *					two loop:
 *
 *                   23, 58, 98, 3, 7, 100	
 *					 23, 58, 98, 3, 7, 100		
 *					 23, 58, 3, 98, 7, 100	
 *			         23, 58, 3, 7, 98, 100							 	
 *                      
 *					three loop:
 *
 *                   23, 58, 3, 7, 98, 100
 *					 23, 3, 58, 7, 98, 100
 *					 23, 3, 7, 58, 98, 100	
 * 
 *					four loop:
 *
 *                   3, 23, 7, 58, 98, 100
 *					 3, 7, 23, 58, 98, 100			    
 *
 *					five loop:
 *
 *                   3, 7, 23, 58, 98, 100		
 **********************************************************************************************************/

%let  BubbleSort = %bquote(98, 58, 23, 100, 3, 7);
%let  Cnt        = %sysfunc(countw(&BubbleSort.));

data _null_;	
	array Bubble [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		Bubble[k] = input(scan("&BubbleSort.", k, ","), best.);		
	end;
	length BubbleSort $30000;
	do i = 1 to (&Cnt. - 1);	
		BubbleSort = "";
		put i " loop :"	;		
		do j = 1 to (&Cnt. - i);
			if Bubble[j] > Bubble[j+1] then do;
				TempVar     = Bubble[j];
				Bubble[j]   = Bubble[j+1];
				Bubble[j+1] = TempVar;				
			end;
		end;
		do l = 1 to &Cnt.;
			BubbleSort = catx(" , ", BubbleSort, Bubble[l]);
		end;
		put BubbleSort;
	end;
	stop;
run;
