/**********************************************************************************************************
 * Macro Name        : Back Tracking                                                                                
 * Purpose           : Back Tracking.                                      
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

/* Eight Queens */

%Macro CallBackTracking(N);
		
	%macro Print;
	
		%local 	i j				
		;		
		%do i = 1 %to &N.;
			%local print&i.;
			%let print&i. = ;
			%do j = 1 %to &N.;
				%if &&Cols&i.. = &j. %then %do;
					%let print&i. = &&print&i.. 1;
				%end;
				%else %do;
					%let print&i. = &&print&i.. 0;
				%end;
			%end;
			%put &&print&i..;
		%end;
	%mend Print;
	
	%macro Effective(R, C);
		%local i j;
		%if &R. > 1 %then %do;
			%do i = 1 %to %eval(&R. - 1);
				/* The same coloumn Cols */				
				%if &&Cols&i.. = &C. %then %do;
					/* %put &R. ROW &C. COL "0"; */
					0
					%return;
				%end;
				/* The diagonal Cols */
				%else %if %eval(&R. - &i.) = %sysfunc(abs(%eval(&C. -  &&Cols&i..))) %then %do;
					/* %put &R. ROW &C. COL "0"; */
					0
					%return;
				%end;							
			%end;		
		%end;
		/* %put &R. ROW &C. COL "1"; */
		1
		%return;
	%mend Effective;
	
	%if &N. < 1 %then %do;
		%return;
	%end;
	%local i Queens;
	%do i = 1 %to &N.;
		%local Cols&i.;
		%let Cols&i. = 0;
	%end;
	%let Queens = 0;
	
	%Macro BackTracking(R);
		
		%if &R. = %eval(&N. + 1) %then %do;
			%let Queens = %eval(1 + &Queens.);
			%put ======&Queens. WAY=======;
			%Print;
			%put ======&Queens. WAY========;
			%return;
		%end;
		
		%local i;		
		%do i = 1 %to &N.;			
			%if %Effective(&R., &i.) > 0 %then %do;				 
				%let Cols&R. = &i.;
				/* %put ==== &&Cols&i..; */
				%BackTracking(%eval(&R. + 1))
			%end;
		%end;
		
	%Mend BackTracking;
	%BackTracking(1)
	
	%put Queens &N. =====> &Queens.;
	
%Mend CallBackTracking;
%CallBackTracking(4)


