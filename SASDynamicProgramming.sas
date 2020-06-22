/**********************************************************************************************************
 * Macro Name        : Dynamic Programming                                                                               
 * Purpose           : Dynamic Programming
 * Author            : Lihong Xiao                                                                         
 * Date              : 10-Apr-2020                                                                         
 * Macro Version     : V1.1.0                                                                              
 *---------------------------------------------------------------------------------------------------------
 * Note		         :  0 0 1 0
 *						1 0 0 0
 *						0 0 0 1
 *						0 1 0 0
 *						
 *                      
 *				                 
 *                                                                         
 **********************************************************************************************************/

/* 

1. Looking for change 
25 20 5 1 ======> 41

Recursive Algorithm 

*/

%Macro CallDynamicProgramming(N=);

		
		%macro DynamicProgramming(N);
			
			%if &N. <  1 %then %do;
				99999999
				%return;
			%end;
		
			%if &N. = 1 or 
				&N. = 5 or 
				&N. = 10 or 
				&N. = 25
			%then %do;
				1 
				%return;
			%end;
			
			%local Min_1 Min_2 Min_3 Min_4;
			
			%let Min_1 = %sysfunc(min(%DynamicProgramming(%eval(&N. - 1)),
									  %DynamicProgramming(%eval(&N. - 5))
									));
			
			%let Min_2 = %sysfunc(min(%DynamicProgramming(%eval(&N. - 10)),
									  %DynamicProgramming(%eval(&N. - 25))
									));
			%let Min_3 = %sysfunc(min(&Min_1.,
									  &Min_2.
									));
			%let Min_4 = %eval(&Min_3. + 1);
			
			&Min_4.
			%return;
			
		%mend DynamicProgramming;	
		
		%put ===============;
		%put %DynamicProgramming(&N.);
		%put ===============;
		
%Mend CallDynamicProgramming;

%CallDynamicProgramming(N = 41)  



/* 

1. Looking for change 
25 20 5 1 ======> 41

Recursive Algorithm - 2

*/

%Macro CallDynamicProgramming(N=);

		
		%local i ;
		
		%do i = 1 %to &N.;
			%local dp&i.;
			%let  dp&i. = 0;
		%end;
		
		%do i = 1 %to 1;			
			%let  dp1 = 1;
			%let  dp5 = 1;
			%let  dp10 = 1;
			%let  dp25 = 1;
		%end;

		%macro DynamicProgramming(N);
			
			%if &N. <  1 %then %do;
				99999999
				%return;
			%end;
		
			%if &&dp&N.. = 0 %then %do;
				
				%local Min_1 Min_2 Min_3 ;
				
				%let Min_1 = %sysfunc(min(%DynamicProgramming(%eval(&N. - 1)),
										  %DynamicProgramming(%eval(&N. - 5))
										));
				
				%let Min_2 = %sysfunc(min(%DynamicProgramming(%eval(&N. - 10)),
										  %DynamicProgramming(%eval(&N. - 25))
										));
				%let Min_3 = %sysfunc(min(&Min_1.,
										  &Min_2.
										));
				%let dp&N. = %eval(&Min_3. + 1);
				
			%end;
			
			&&dp&N..
			%return;
			
		%mend DynamicProgramming;	
		
		%put ===============;
		%put %DynamicProgramming(&N.);
		%put ===============;
		
%Mend CallDynamicProgramming;

%CallDynamicProgramming(N = 41)  


/* 

1. Looking for change 
25 20 5 1 ======> 41

Recursive Algorithm - 3

*/

%Macro CallDynamicProgramming(N=);
		
	%macro DynamicProgramming(N);
		
		%if &N. <  1 %then %do;
			99999999
			%return;
		%end;
		
		%local i ;
		
		%do i = 1 %to &N.;
			%local dp&i.;
			%let  dp&i. = 0;
		%end;
		
		%local Min_1;
		%do i = 2 %to %eval(&N.+1);
		
			%local j;
			%let j = %eval(&i. - 1);
			%let Min_1 = &&dp&j..;
			
			%if &I. > 5 %then %do;
				%let j = %eval(&i. - 5);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
			%end;
			%if &I. > 10 %then %do;
				
				%let j = %eval(&i. - 10);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
			%end;
			%if &I. > 25 %then %do;
				%let j = %eval(&i. - 25);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
			%end;
			
			%let dp&i. = %eval(&Min_1. + 1);
		
		%end;
		%let N = %eval(&N. + 1);
		
		&&dp&N..
		%return;
		
	%mend DynamicProgramming;	
	
	%put ===============;
	%put %DynamicProgramming(&N.);
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(N = 41)  

/* 

1. Looking for change 
25 20 5 1 ======> 41

Dynamic Programming- 4

*/


%Macro CallDynamicProgramming(N=);
	
	%macro printf(N);
	
		%do %while(&N. > 0);
			%put =========;
			%put &&fc&N.;	
			%put &N.;
			%put =========;
			%let N = %eval(&N. - &&fc&N..);
		%end;
			
	%mend printf;
	
	%macro DynamicProgramming(N);
		
		%if &N. <  1 %then %do;
			99999999
			%return;
		%end;
		
		%local i;
		
		%do i = 1 %to &N.;
			%local dp&i. ;
			%global fc&i.;
			%let  dp&i. = 0;
			%let  fc&i. = 0;
		%end;
		
		%local Min_1;
		%do i = 2 %to %eval(&N.+1);
		
			%local j;
			%let j = %eval(&i. - 1);
			%let Min_1 = &&dp&j..;
			%if &I. <= 5 %then 	%let fc&j. = 1;
			
			%if &I. > 5 %then %do;
				%let j = %eval(&i. - 5);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
				%let fc&j. = 5;
			%end;
			%if &I. > 10 %then %do;
				
				%let j = %eval(&i. - 10);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
				%let fc&j. = 10;
			%end;
			%if &I. > 25 %then %do;
				%let j = %eval(&i. - 25);
				%let Min_1 = %sysfunc(min(&&dp&j.., &Min_1.));
				%let fc&j. = 25;
			%end;
			
			%let dp&i. = %eval(&Min_1. + 1);
		
		%end;
		
		
	
		%let N = %eval(&N. + 1);	
		
		&&dp&N..
		%return;
		
	%mend DynamicProgramming;	
	
	
	%put ===============;
	%put %DynamicProgramming(&N.);
	%put ===============;
	%printf(&N.)
%Mend CallDynamicProgramming;

%CallDynamicProgramming(N = 41)  

/* summary maximum continuous subsequence --1 */


/* Delete the dataset including func */

/* proc datasets library = work memtype = data nolist;
	delete funcs ;
run;
 */
proc fcmp outlib = work.funcs.Summary;

	function SummarySubsequence(s[*]) varargs;
	
		if dim(s) = 0 then do;
			return(0);
		end;
		
		array DP [*] DP1-DP100;		
		do i = 1 to dim(s);
			DP[i] = 0;
		end;
		
		MaxV = s[1];
		DP[1] = s[1];
		
		do i = 2 to dim(s);
			PREV = DP[i - 1];
			if PREV > 0 then do;
				DP[i] = PREV + s[i];
			end;
			else do;
				DP[i] = s[i];
			end;
			MaxV = Max(MaxV, DP[i]);
		end;
		
		return(MaxV);
		
	endsub;
	
	TestArray = SummarySubsequence(-2, 1, -3, 4, -1, 2, 1, 1, -5, 4);	
	put TestArray =;
quit;

/* summary maximum continuous subsequence --2 */


proc fcmp outlib = work.funcs.Summary;

	function SummarySubsequence(s[*]) varargs;
	
		if dim(s) = 0 then do;
			return(0);
		end;
		
		DP = s[1];		
		MaxV = DP;		
		
		do i = 2 to dim(s);			
			if DP > 0 then do;
				DP = DP + s[i];
			end;
			else do;
				DP = s[i];
			end;
			MaxV = Max(MaxV, DP);
		end;
		
		return(MaxV);
		
	endsub;
	
	TestArray = SummarySubsequence(-2, 1, -3, 4, -1, 2, 1, 1, -5, 4);	
	put TestArray =;
quit;

/* Longest ascending subsequence --1 */

proc fcmp outlib = work.funcs.Summary;

	function SummarySubsequence(s[*]) varargs;
	
		if dim(s) = 0 then do;
			return(0);
		end;
		
		array DP [*] DP1-DP100;		
		do i = 1 to dim(s);
			DP[i] = 1;
		end;
		
		MaxV = DP[1];
		
		do i = 2 to dim(s);
			DP[i] = 1;			
			do j = 1 to i;
				if  s[i] > s[j] then do;
					Temp  = DP[j] + 1;				
					DP[i] = max(DP[i], Temp);
				end;				
			end;			
			MaxV = max(MaxV, DP[i]);
		end;
		
		return(MaxV);
		
	endsub;
		
	TestArray = SummarySubsequence(1,10,2,2,5,1,7,101,18,19,7);	
	put TestArray =;
quit;

/* Longest ascending subsequence --2 binary search */

proc fcmp outlib = work.funcs.Summary;

	function SummarySubsequence(s[*]) varargs;
	
		if dim(s) = 0 then do;
			return(0);
		end;
		
		array DP [*] DP1-DP100;		
		do i = 1 to dim(s);
			DP[i] = 0;
		end;		
		len = 1;
		
		do i = 1 to dim(s);
		
			begin = 1;
			end   = len;
			
			do while(begin < end);
				mid = floor((begin + end)/2);
				if s[i] <= DP[mid] then do;
					end = mid;
				end;
				else do;
					begin = mid + 1;
				end;
			end;
			
			DP[begin] = s[i];
			if begin = len then len = len + 1;
		end;
		
		return(len);
		
	endsub;
		
	TestArray = SummarySubsequence(1,10,2,2,5,1,7,101,18,19,7);	
	put TestArray =;
quit;



/* Longest common subsequence --1 */

/* [1, 2, 3, 5, 13, 14]
[1,8, 2, 13, 14]
 */
/* 

proc fcmp outlib = work.funcs.Longest;

	subroutine LongestSubsequence(T1[*], len1, T2[*], len2, temp);
		outargs temp;
		if len1 = 0 or len2 = 0 then do;
			temp = 0;
			return;
		end;
		if dim(T1) = 0 then do;
			temp = 0;
			return;
		end;
		if dim(T2) = 0 then do;
			temp = 0;
			return;
		end;
		
		if T1[len - 1] =  T2[len - 1] then do;
			temp = LongestSubsequence(T1[*], len1 - 1, T2[*], len2 - 1, temp) + 1;
			
		end;	
		else do;
		
			call LongestSubsequence(T1[*], len1 - 1, T2[*], len2, temp);
			test1 = temp;
			call LongestSubsequence(T1[*], len1, T2[*], len2 - 1, temp);
			test2 = temp;
			
			if test1 > test2 then temp = test1;
			else temp = test2;
			
			
		end;
		
		return;
		
	endsub;
	
quit;

data _null_;

	array T1 [6] _temporary_ (1 2 3 5 13 14);
	array T2 [5] _temporary_ (1 8 2 13 14);

	len1 = dim(T1);
	len2 = dim(T2);
	TestArray = 0;
	
	call LongestSubsequence(T1, len1, T2, len2, TestArray);
	put TestArray;

run;
 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
	
	
	%macro DynamicProgramming(len1, len2);
		%local LengthN;
		%if &len1.       = 1 %then %do;
			%let LengthN = 0;
			&LengthN.	
			%return;		
		%end;
		
		%if &len2.       = 1 %then %do;
			%let LengthN = 0;
			&LengthN.	
			%return;		
		%end;
		
		%local  len1temp
				len2temp
		;
		
		%let len1temp = %eval(&len1. - 1);
		%let len2temp = %eval(&len2. - 1);
		
		%if &&Array1&len1temp.. = &&Array2&len2temp.. %then %do;
			%let LengthN = %eval(%DynamicProgramming(&len1temp, &len2temp.) + 1);
			&LengthN.			
		%end;
		%else %do;
			%local LengthNTemp1 LengthNTemp2;
			%let LengthNTemp1 = %DynamicProgramming(&len1temp, &len2.);
			%let LengthNTemp2 = %DynamicProgramming(&len1., &len2temp.);			
			%let LengthN = %sysfunc(max(&LengthNTemp1. ,  &LengthNTemp2.));
			&LengthN.			
		%end;
				
	%mend DynamicProgramming;	
	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&len1. + 1), %eval(&len2. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(1 2 3 5 13 14), TestArray2 = %str(1 8 2 13 14))

/* Longest common subsequence --2 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%macro DynamicProgramming(len1, len2);
		
		%local i j;
			
		%do i = 1 %to &len1.;
			%do j = 1 %to &len2.;
				%local DP&I.&J.;
				%let DP&I.&J. = 0;
			%end;
		%end;
		
		%local  len1temp
				len2temp
		;
		
		%do i = 2 %to &len1.;
			%do j = 2 %to &len2.;		
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%if &&Array1&len1temp.. = &&Array2&len2temp.. %then %do;
					%let DP&I.&J. = %eval(&&DP&len1temp.&len2temp.. + 1);							
				%end;
				%else %do;								
					%let DP&I.&J. = %sysfunc(max(&&DP&len1temp.&J.., &&DP&I.&len2temp..));							
				%end;
				
			%end;
		%end;
		
		&&DP&len1.&len2..
		
	%mend DynamicProgramming;	
	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&len1. + 1), %eval(&len2. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(1 2 3 5 13 14), TestArray2 = %str(1 8 2 13 14))

/* Longest common subsequence --3 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%macro DynamicProgramming(len1, len2);
		
		%local i j;
			
		%do i = 0 %to 1;
			%do j = 1 %to &len2.;
				%local DP&I.&J.;
				%let DP&I.&J. = 0;
			%end;
		%end;
		
		%local  len1temp
				len2temp
				R
				PR
		;
		
		%do i = 2 %to &len1.;
			%do j = 2 %to &len2.;	
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%let R = %sysfunc(band(&i., 1));
				%let PR = %sysfunc(band(%eval(&i. - 1), 1));
				
				%if &&Array1&len1temp.. = &&Array2&len2temp.. %then %do;
					%let DP&R.&J. = %eval(&&DP&PR.&len2temp.. + 1);							
				%end;
				%else %do;								
					%let DP&R.&J. = %sysfunc(max(&&DP&PR.&J.., &&DP&R.&len2temp..));							
				%end;
				
			%end;
		%end;
		
		&&DP&R.&len2..
		
	%mend DynamicProgramming;	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&len1. + 1), %eval(&len2. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(1 2 3 5 13 14), TestArray2 = %str(1 8 2 13 14))

/* Longest common subsequence --4 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%macro DynamicProgramming(len1, len2);
		
		%local i j;
			
	
		%do j = 1 %to &len2.;
			%local DP&J.;
			%let DP&J. = 0;
		%end;
		
		
		%local  len1temp
				len2temp
				R
				PR
		;
		
		%local LeftTop;
		%local Cut;
		
		%do i = 2 %to &len1.;
		
			%let Cut = 0;
			
			%do j = 2 %to &len2.;	
			
				%let LeftTop = &Cut.;
				%let Cut = &&DP&J..;
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%if &&Array1&len1temp.. = &&Array2&len2temp.. %then %do;
					%let DP&J. = %eval(&LeftTop. + 1);
				%end;
				%else %do;
					%let DP&J. = %sysfunc(max(&&DP&J.., &&DP&len2temp..));						
				%end;		
			
			%end;
			
		%end;
		
		&&DP&len2..
		
	%mend DynamicProgramming;	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&len1. + 1), %eval(&len2. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(1 2 3 5 13 14), TestArray2 = %str(1 8 2 13 14))


/* Longest common subsequence --5 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%local  CN
			CA 
			RN
			RA
	;
	
	%if &len1. < &len2. %then %do;
		%let CN = &len1.;
		%let CA = Array1;
		%let RN = &len2.;
		%let RA = Array2;
	%end;
	%else %do;
		%let CN = &len2.;
		%let CA = Array2;
		%let RN = &len1.;
		%let RA = Array1;
	%end;
	
	%macro DynamicProgramming(len1, len2);
		
		%local i j;
			
	
		%do j = 1 %to &len2.;
			%local DP&J.;
			%let DP&J. = 0;
		%end;
			
		%local  len1temp
				len2temp
				R
				PR
		;
		
		%local LeftTop;
		%local Cut;
		
		%do i = 2 %to &len1.;
		
			%let Cut = 0;		
			%do j = 2 %to &len2.;	
			
				%let LeftTop = &Cut.;
				%let Cut = &&DP&J..;
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%if &&&RA.&len1temp.. = &&&CA.&len2temp.. %then %do;
					%let DP&J. = %eval(&LeftTop. + 1);
				%end;
				%else %do;
					%let DP&J. = %sysfunc(max(&&DP&J.., &&DP&len2temp..));						
				%end;	
			%end;			
		%end;
		
		&&DP&len2..
		
	%mend DynamicProgramming;	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&RN. + 1), %eval(&CN. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(1 2 3 5 13 14), TestArray2 = %str(1 8 2 13 14))


/* Longest common substring --1 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%macro DynamicProgramming(len1, len2);
		
		%local i j Max;
			
		%do i = 1 %to &len1.;
			%do j = 1 %to &len2.;
				%local DP&I.&J.;
				%let DP&I.&J. = 0;
			%end;
		%end;
		%let Max = 0;
		
		%local  len1temp
				len2temp
		;
		
		%do i = 2 %to &len1.;
			%do j = 2 %to &len2.;		
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%if &&Array1&len1temp.. = &&Array2&len2temp.. %then %do;
					%let DP&I.&J. = %eval(&&DP&len1temp.&len2temp.. + 1);		
					%let Max      = %sysfunc(max(&Max., &&DP&I.&J..));					
				%end;
			
			%end;
		%end;
		
		&Max.
		
	%mend DynamicProgramming;	
	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&len1. + 1), %eval(&len2. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(N A B C E D), TestArray2 = %str(N A B C D G))

/* Longest common substring --2 */

%Macro CallDynamicProgramming(TestArray1 = %str(), TestArray2 = %str());
		
	%local  len1
			len2
			i
	;
	%let len1 = %sysfunc(countw(&TestArray1.));
	%let len2 = %sysfunc(countw(&TestArray2.));
	
	%do i = 1 %to &len1.;
		%local Array1&i.;
		%let Array1&i. = %scan(&TestArray1., &i., %str( ));		
	
	%end;
	
	%do i = 1 %to &len2.;
		%local Array2&i.;
		%let Array2&i. = %scan(&TestArray2., &i., %str( ));		
	%end;
		
	%local  CN
			CA 
			RN
			RA
	;
	
	%if &len1. < &len2. %then %do;
		%let CN = &len1.;
		%let CA = Array1;
		%let RN = &len2.;
		%let RA = Array2;
	%end;
	%else %do;
		%let CN = &len2.;
		%let CA = Array2;
		%let RN = &len1.;
		%let RA = Array1;
	%end;
	
	%macro DynamicProgramming(len1, len2);
		
		%local i j Max;
		
		%do j = 1 %to &len2.;
			%local DP&J.;
			%let DP&J. = 0;
		%end;
		%let Max = 0;	
		
		%local  len1temp
				len2temp
				R
				PR
		;
		
		%local LeftTop;
		%local Cut;
		
		%do i = 2 %to &len1.;
		
			%let Cut = 0;		
			%do j = 2 %to &len2.;	
			
				%let LeftTop = &Cut.;
				%let Cut = &&DP&J..;
			
				%let len1temp = %eval(&i. - 1);
				%let len2temp = %eval(&j. - 1);
				
				%if &&&RA.&len1temp.. = &&&CA.&len2temp.. %then %do;
					%let DP&J. = %eval(&LeftTop. + 1);
					%let Max      = %sysfunc(max(&Max., &&DP&J..));					
				%end;
				%else %do;
					%let DP&J. = 0;
				%end;
				
			%end;			
		%end;
		
		&Max.
		
	%mend DynamicProgramming;	
	
	%put ===============;
	%put %DynamicProgramming(%eval(&RN. + 1), %eval(&CN. + 1));	
	%put ===============;
	
%Mend CallDynamicProgramming;

%CallDynamicProgramming(TestArray1 = %str(N A B C E D), TestArray2 = %str(N A B C D G))


