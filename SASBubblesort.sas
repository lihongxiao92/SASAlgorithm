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

/* Sort 1: without Optimization of BubbleSort */

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

/* Sort 2: with optimization for totally sorting */

%let  BubbleSort = %bquote(3, 7, 23, 58, 98, 100);
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
		/* If the array has been sorted, then over this loop. */
		SortFlag = 1;
		do j = 1 to (&Cnt. - i);
			if Bubble[j] > Bubble[j+1] then do;
				TempVar     = Bubble[j];
				Bubble[j]   = Bubble[j+1];
				Bubble[j+1] = TempVar;		
				SortFlag = 0;
			end;
		end;		
		do l = 1 to &Cnt.;
			BubbleSort = catx(" , ", BubbleSort, Bubble[l]);
		end;
		put BubbleSort;
		if SortFlag = 1 then leave;
	end;
	stop;
run;

/* Sort 3: without Optimization for partial sorting */
%let  BubbleSort = %bquote(7, 3, 23, 58, 98, 100); 
%let  Cnt        = %sysfunc(countw(&BubbleSort.));

data _null_;	
	array Bubble [&Cnt.]  _temporary_;
	do k = 1 to &Cnt.;
		Bubble[k] = input(scan("&BubbleSort.", k, ","), best.);		
	end;
	length BubbleSort $30000;
	Index1 = (&Cnt. - 1);
	do i = 1 to Index1 while(Index1 > 2);	
		BubbleSort = "";
		put i " loop :"	;
		/* If the array has been partial sorting, then record this index. */
		SortFlag = 1;
		Index2 = (&Cnt. - i);
		do j = 1 to Index2;
			if Bubble[j] > Bubble[j+1] then do;
				TempVar     = Bubble[j];
				Bubble[j]   = Bubble[j+1];
				Bubble[j+1] = TempVar;		
				SortFlag = j+1;			
			end;
		end;		
		do l = 1 to &Cnt.;
			BubbleSort = catx(" , ", BubbleSort, Bubble[l]);
		end;
		put BubbleSort;
		Index1 = SortFlag;		
	end;
	stop;
run;

