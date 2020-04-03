/**********************************************************************************************************
 * Macro Name        : Quick Sort                                                                                 
 * Purpose           : Quick Sort .                                      
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

%Macro CallQuickSort;
	%local QuickSort
			Cnt
	;
	%let  QuickSort = %bquote(57 ,46, 98, 58, 23, 100, 3, 7, 8);
	%let  Cnt       = %sysfunc(Countw(&QuickSort.));
	
	/* Create the macro array */
	
	%do I = 1 %to &Cnt.;
		%local QuickSort&I.;		
		%let QuickSort&I. = %scan(&QuickSort., &I., %str(,));		
	%end;
	
	%macro pivot(Begin, End);
		%local pivot;	
		/* BackUp the pivot element. */
		%let pivot = &&QuickSort&Begin..;
		%do %while(&Begin. < &End.);
		
			%do %while(&Begin. < &End.);
				%if &pivot. < &&QuickSort&End.. %then %do;
					%let End = %eval(&End. - 1);
				%end;
				%else %do;
					%let QuickSort&Begin. = &&QuickSort&End..;
					%let Begin = %eval(&Begin. + 1);
					%goto label1;
				%end;
			%end;			
			%label1:
			
			%do %while(&Begin. < &End.);
				%if &pivot. > &&QuickSort&Begin.. %then %do;
					%let Begin = %eval(&Begin. + 1);
				%end;
				%else %do;
					%let QuickSort&End. = &&QuickSort&Begin..;
					%let End = %eval(&End. - 1);
					%goto label2;
				%end;				
			%end;
			%label2:
			
		%end;
		
		%let QuickSort&Begin. = &pivot.;		
		
		%Returnvalue: &Begin.
		
	%mend pivot;
	
	%macro QuickSort(Begin, End);
	
		%if %eval(&End. - &Begin.) < 2 %then %do;			
			%return;
		%end;
		%let Middle = %pivot(&Begin., &End.);
		
		%QuickSort(&Begin., &Middle.)
		%QuickSort(%eval(&Middle. + 1), &End.)
	%mend QuickSort;
	
	%QuickSort(1, &Cnt.)
	
	%local QuickSortT;
	%let QuickSortT = ;
	%do J = 1 %to &Cnt.;
		%if &J. = 1 %then %let QuickSortT = &&QuickSort&J..;
		%else %let QuickSortT = &QuickSortT. , &&QuickSort&J..;
	%end;
	%put &QuickSortT.;
	
%Mend CallQuickSort;

%CallQuickSort
