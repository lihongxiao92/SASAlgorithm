/**********************************************************************************************************
 * Macro Name        : Insertion sort                                                                                 
 * Purpose           : Insertion Sort .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 98, 58, 23, 100, 3, 7
 *						
 *					one loop:
 *
 *                   58, 98, 23, 100, 3, 7	
 *			         	   
 *					two loop:
 *
 *                   23, 58, 98, 100, 3, 7					 	
 *                      
 *					three loop:
 *
 *                   23, 58, 98, 100, 3, 7					 	
 * 
 *					four loop:
 *
 *                  3, 23, 58, 98, 100, 7				
 *
 *					five loop:
 *
 *                   3, 7, 23, 58, 98, 100		
 **********************************************************************************************************/
 
%let  InsertSort = %bquote(98, 58, 23, 100, 3, 7);
%let  Cnt        = %sysfunc(countw(&InsertSort.));

data _null_;
	array InsertST [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		InsertST[k] = input(scan("&InsertSort.", k, ","), best.);		
	end;
	length InsertSort $30000;
	do i = 2 to &Cnt.;	
		InsertSort = "";
		put i " loop :";		
		TempVar = InsertST[i];
		do j = i - 1 to 1 by -1;	
			if InsertST[j] > InsertST[j+1] then do;
				InsertSTTemp = InsertST[j];
				InsertST[j] = InsertST[j+1];
				InsertST[j+1] = InsertSTTemp;	
			end;
		end;			
		do l = 1 to &Cnt.;
			InsertSort = catx(" , ", InsertSort, InsertST[l]);
		end;
		put InsertSort;
	end;
	stop;
run;

data _null_;
	array InsertST [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		InsertST[k] = input(scan("&InsertSort.", k, ","), best.);		
	end;
	length InsertSort $30000;
	do i = 2 to &Cnt.;	
		InsertSort = "";
		put i " loop :";
		j = i - 1;
		TempVar = InsertST[i];
		do while(TempVar <= InsertST[j]);			
			InsertST[j+1] = InsertST[j];			
			j = j - 1;					
			if j <= 0 then leave;
		end;		
		InsertST[j + 1] = TempVar;	
		do l = 1 to &Cnt.;
			InsertSort = catx(" , ", InsertSort, InsertST[l]);
		end;
		put InsertSort;
	end;
	stop;
run;
