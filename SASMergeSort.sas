/**********************************************************************************************************
 * Macro Name        : Merge Sort                                                                                 
 * Purpose           : Merge Sort .                                      
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

%Macro CallMergeSort(Begin, End);

	%local MergeSort
			Cnt
	; 
	%let  MergeSort = %bquote(57 ,46, 2, 98, 58, 23, 100, 3, 7, 8);
	%let  Cnt        = %sysfunc(Countw(&MergeSort.));
	
	/* Create the macro array */
	
	%do I = 1 %to &Cnt.;
		%local MergeSort&I.;		
		%let MergeSort&I. = %scan(&MergeSort., &I., %str(,));		
	%end;
	
	%macro Merge(Begin, Middle, End);
	
		%put Begin ====> &Begin.;
		%put End   ====> &End.;
		%put Middle ====> &Middle.;
		
		%local 	LeftIndex
				LeftLength
				RightIndex
				RightLength
				Index
		;
		%let LeftIndex = 1;
		%let LeftLength  = %eval(&Middle. - &Begin.  + 1);
		%let RightIndex  = %eval(&Middle. + 1);
		%let RightLength = &End.;
		%let Index       = &Begin.;
		
		/* Copy the left array */
		%local J TempIndex;		
		%do J = &LeftIndex. %to &LeftLength.;			
			%if &J. = 1 %then %let TempIndex   = %eval(0 + &Begin.);
			%else %let TempIndex   = %eval(&J. - 1 + &Begin.);			
			%let CopySort&J. = &&MergeSort&TempIndex..;			
		%end;
		
		/* Merge the sorted array */
		%do %while(&LeftIndex. <= &LeftLength.);
			%if &RightIndex. <= &RightLength.
			%then %do;
				%if &&MergeSort&RightIndex.. < &&CopySort&LeftIndex.. %then %do;
					%let MergeSort&Index. = &&MergeSort&RightIndex..;		
					%put MergeSortIndex =====> &&MergeSort&Index..;
					%let Index = %eval(&Index. + 1);
					%let RightIndex = %eval(&RightIndex. + 1);					
				%end;
				%else %do;
					%let MergeSort&Index. = &&CopySort&LeftIndex..;		
					%put MergeSortIndex1 =====> &&MergeSort&Index..;
					%let Index = %eval(&Index. + 1);
					%let LeftIndex = %eval(&LeftIndex. + 1);						
				%end;
			%end;
			%else %do;
				%let MergeSort&Index. = &&CopySort&LeftIndex..;		
				%put MergeSortIndex2 =====> &&MergeSort&Index..;
				%let Index = %eval(&Index. + 1);				
				%let LeftIndex = %eval(&LeftIndex. + 1);				
			%end;			
		%end;
		
	%mend Merge;
	
	%macro MergeSort(Begin, End);
		
		%if %eval(&End. - &Begin.) < 1 %then %do;			
			%return;
		%end;
		%local Middle;
		%let Middle = %sysfunc(floor((&End. + &Begin.)/2));
		
		%MergeSort(&Begin., &Middle.)
		%MergeSort(%eval(&Middle. + 1), &End.)		
		%Merge(&Begin., &Middle., &End.)
		
	%mend MergeSort;
	
	/* Create the temporary array to copy. */
	
	%do I = 1 %to %sysfunc(floor(&Cnt./2));
		%local CopySort&I.;		
		%let CopySort&I. =;		
	%end;
	
	%MergeSort(1, &Cnt.)
	
	%local MergeSortT;
	%let MergeSortT = ;	
	%do J = 1 %to &Cnt.;		
		%if &J. = 1 %then %let MergeSortT = &&MergeSort&J..;
		%else %let MergeSortT = &MergeSortT. , &&MergeSort&J..;
	%end;
	%put &MergeSortT.;
%Mend CallMergeSort;

%CallMergeSort
