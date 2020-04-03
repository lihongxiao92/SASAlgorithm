/**********************************************************************************************************
 * Macro Name        : Shell Sort                                                                                 
 * Purpose           : Shell Sort .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 57 ,46, 98, 58, 23, 100, 3, 7, 8
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
 
%let  ShellSort = %bquote(57 ,46, 98, 58, 23, 100, 3, 7, 8);
%let  Cnt        = %sysfunc(countw(&ShellSort.));

data _null_;	
	array ShellST [&Cnt.] _temporary_;
	do k = 1 to &Cnt.;
		ShellST[k] = input(scan("&ShellSort.", k, ","), best.);		
	end;
	/* Get the step sequence */
	Step = floor(&Cnt./2);
	length ShellSort $30000;
	do while(Step > 0);
		ShellSort = "";
		/* Sort for every coloumn */
		do i = 1 to Step;
		/*  Sort for every coloumn every element */
			do j = i + step to &Cnt. by Step;
				TempIndex = j;
				put TempIndex ;
				/*  Change for the INDEX */
				do while(TempIndex > i and ShellST[TempIndex] < ShellST[TempIndex - Step]);
					TempVar = ShellST[TempIndex];
					ShellST[TempIndex] = ShellST[TempIndex - Step];
					ShellST[TempIndex - Step] = TempVar;
					TempIndex = TempIndex - Step;					
					if (TempIndex - Step) <= 0 then leave; 
				end;
			end;
		end;		
		do l = 1 to &Cnt.;
			ShellSort = catx(" , ", ShellSort, ShellST[l]);
		end;
		put ShellSort;
		Step = floor(Step/2);
	end;
run;

