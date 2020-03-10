/**********************************************************************************************************
 * Macro Name        : Binary Search                                                                                 
 * Purpose           : Binary Search .                                      
 * Author            : Lihong Xiao                                                                         
 * Date              : 04-March-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         : 3, 7, 23, 35, 58, 98, 100
 *						Search the index of 98
 *                         
 *					one loop:
 *
 *					 Target     = 98;
 *                   BeginIndex = 1;
 *                   MidIndex   = 4;
 *                   EndIndex   = 7;
 *			         Mid        = 35;
 *                   Mid < Target;
 *                   
 *
 *					two loop:
 *
 *					 Target     = 98;
 *                   BeginIndex = MidIndex + 1;
 *                   MidIndex   = floor((MidIndex + 1 + EndIndex)/2);
 *                   EndIndex   = 7;
 *			         Mid        = 98;
 *                   Mid = Target;
 *                   					 	
 **********************************************************************************************************/

%let  BinarySearch = %bquote(3, 7, 23, 58, 98, 100);
%let  Cnt          = %sysfunc(countw(&BinarySearch.));
%let  Target       = 3;

data _null_;
	array BinarySH [&Cnt.]   _temporary_;
	do k = 1 to &Cnt.;
		BinarySH[k] = input(scan("&BinarySearch.", k, ","), best.);		
	end;
	
	Target     = &Target.;
	BeginIndex = 1;
	EndIndex   = &Cnt.;
	
	do while(1);
		MidIndex   = floor((BeginIndex + EndIndex)/2);
		if BinarySH[MidIndex] = Target then do;
			put Target " index is " MidIndex;	
			leave;
		end;
		else if  BinarySH[MidIndex] > Target then do;
			EndIndex = MidIndex - 1;			
		end;
		else if  BinarySH[MidIndex] < Target then do;
			BeginIndex = MidIndex + 1;			
		end;
		if   (BeginIndex > EndIndex) or			
			((BeginIndex > &Cnt.) or (EndIndex < 1))
		then do;
			put Target " index is not in the list.";	
			leave;
		end;
	end;
	stop;
run;
