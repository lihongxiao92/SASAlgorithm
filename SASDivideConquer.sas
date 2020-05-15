/**********************************************************************************************************
 * Macro Name        : Divide Conquer                                                                               
 * Purpose           : Divide Conquer.                                      
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


/* Sum of maximum consecutive subsequences */
/* -2, 1, -3, 4, -1, 2, 1, -5, 4*/

%Macro CallDivideConquer(ArrayList =);

		%local i totalN;			
		%let totalN = %sysfunc(countw(&ArrayList.));
		%do i = 1 %to %sysfunc(countw(&ArrayList.));
			%local Divide&i.;		
			%let Divide&i. = %unquote(%scan(&ArrayList., &i., %str(,)));		
			%put &&Divide&i..; 
		%end;
				
		%macro DivideConquer;
			
			%local i j k;
			%local Max Sum;
			
			%let Max = -9999999;
			
			%do i = 1 %to &totalN.;
				%do j = &i. %to &totalN.;
					%let Sum = 0;					
					%do k = &i. %to &j.;							
						%if &&Divide&k.. < 0 %then %do;
							%let Sum = %eval(&sum. &&Divide&k..);							
						%end;
						%else %do;
							%let Sum = %eval(&sum. + &&Divide&k..);
						%end;						
					%end;					
					%if %eval(&Max. < &Sum.) %then %do;
						%let Max = &Sum.;
					%end;					
				%end;				
			%end;
			
			%put ======;
			%put &Max.;
			%put ======;
			
		%mend DivideConquer;		
		%DivideConquer  
		
		
%Mend CallDivideConquer;

%CallDivideConquer(ArrayList = %bquote(-2,1,-3,4,-1,2,1,-5,4))  

/* Improve the Algorithm - 1 */

%Macro CallDivideConquer(ArrayList =);

		%local i totalN;			
		%let totalN = %sysfunc(countw(&ArrayList.));
		%do i = 1 %to %sysfunc(countw(&ArrayList.));
			%local Divide&i.;		
			%let Divide&i. = %unquote(%scan(&ArrayList., &i., %str(,)));		
			%put &&Divide&i..; 
		%end;
				
		%macro DivideConquer;
			
			%local i j k;
			%local Max Sum;
			
			%let Max = -9999999;			
			%do i = 1 %to &totalN.;
				%let Sum = 0;		
				%do j = &i. %to &totalN.;			
					%if &&Divide&j.. < 0 %then %do;
						%let Sum = %eval(&sum. &&Divide&j..);							
					%end;
					%else %do;
						%let Sum = %eval(&sum. + &&Divide&j..);
					%end;		
					%if %eval(&Max. < &Sum.) %then %do;
						%let Max = &Sum.;
					%end;					
				%end;				
			%end;
			
			%put ======;
			%put &Max.;
			%put ======;
			
		%mend DivideConquer;		
		%DivideConquer  
		
		
%Mend CallDivideConquer;

%CallDivideConquer(ArrayList = %bquote(-2,1,-3,4,-1,2,1,-5,4))  

/* Improve the Algorithm - 2 Divide Conquer */

%Macro CallDivideConquer(ArrayList =);

		%local i totalN;			
		%let totalN = %sysfunc(countw(&ArrayList.));
		%do i = 1 %to %sysfunc(countw(&ArrayList.));
			%local Divide&i.;		
			%let Divide&i. = %unquote(%scan(&ArrayList., &i., %str(,)));		
			%put &&Divide&i..; 
		%end;

		%macro DivideConquer(begin , End );
		
			%if %eval(&End. - &Begin.) < 1 %then %do;
				&&&Divide&begin..
				%return;	
			%end;
			
			%local i Mid LeftMax LeftSum;
			
			%let Mid = %sysfunc(floor((&End. + &Begin.)/2));
			%let LeftMax = &&Divide&Mid..;
			%let LeftSum = &&Divide&Mid..;
			
			%do i = %eval(&Mid. - 1) %to &Begin. %by -1;
				%if &&Divide&i.. < 0 %then %do;
					%let LeftSum = %eval(&LeftSum. &&Divide&i..);							
				%end;
				%else %do;
					%let LeftSum = %eval(&LeftSum. + &&Divide&i..);
				%end;	
				%if %eval(&LeftMax. < &LeftSum.) %then %do;
					%let LeftMax = &LeftSum.;
				%end;
			%end;
			
			%local MidNext RightMax RightSum;
			%let MidNext = %eval(&Mid. + 1) ;
			%let RightMax = &&Divide&MidNext..;
			%let RightSum = &&Divide&MidNext..;
			
			%do i = %eval(&MidNext.+1) %to &End.;
				%if &&Divide&i.. < 0 %then %do;
					%let RightSum = %eval(&RightSum. &&Divide&i..);							
				%end;
				%else %do;
					%let RightSum = %eval(&RightSum. + &&Divide&i..);
				%end;	
				%if %eval(&RightMax. < &RightSum.) %then %do;
					%let RightMax = &RightSum.;
				%end;
			%end;
			
			%local Max_1 Max_2 Max_3 Max_4 Max_5;
			%let Max_1 = %eval(&LeftMax. + &RightMax.);
			
			%let Max_2 = %DivideConquer(&Begin., &Mid.);
			%let Max_3 = %DivideConquer(&MidNext., &End.);
			%let Max_4 = %sysfunc(max(&Max_2., &Max_3.));	
			
			%let Max_5 = %sysfunc(max(&Max_1., 0));
			
			&Max_5.			
			%return;
			
		%mend DivideConquer;		
				
		%put ======;
		%put %DivideConquer(1, &totalN.);
		%put ======;
		
		
%Mend CallDivideConquer;

%CallDivideConquer(ArrayList = %bquote(-2,1,-3,4,-1,2,1,-5,4))  
