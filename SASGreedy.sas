/**********************************************************************************************************
 * Macro Name        : Greedy                                                                               
 * Purpose           : Greedy.                                      
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


/* The optimal loading */

%Macro CallGreedy(weight = , totalWeight = );

	%local i weightSort  totalN;	
	%let weightSort =;	
	%let totalN    = 0;
	%do i = 1 %to %sysfunc(countw(&weight.));
		%local weight&i.;		
		%let weight&i. = %scan(&weight., &i., %str(,));
		%if &i. = 1 %then %do;
			%let weightSort = weight&i.;
		%end;
		%else %do;
			%let weightSort = &weightSort., weight&i.;
		%end;
	%end;

	/* sort the array */	
	%syscall sortn(&weightSort.);
	%put ============;
	%do i = 1 %to %sysfunc(countw(&weight.)); 		
		%put &&weight&i..;		
	%end;
	%put ============;
	
	%macro Greedy;
		%local i weights;
		%let weights = 0;
		%do i = 1 %to %sysfunc(countw(&weight.)) ;		
			%if %eval( %eval(&weights. + &&weight&i..) > &totalWeight.) %then %do;
				%goto EXITDO;
			%end;
			%if &weights. <= &totalWeight. %then %do;
				%let weights = %eval(&weights. + &&weight&i..);				
				%put &&weight&i..;
				%let totalN = %eval(&totalN. + 1);				
			%end;
		%end;
		
		%EXITDO:
		
	%mend Greedy;
	
	%Greedy
	
	%put ============;
	%put &totalN.;
	%put ============;
	
%Mend CallGreedy;
%CallGreedy(weight = %nrbquote(3, 4, 10, 6, 7, 15, 9, 11, 16), totalWeight = 40)

/* Small change change ----1 */

%Macro CallGreedy(Face = , Money = );

	%local i FaceSort  totalN;	
	%let FaceSort =;	
	%let totalN    = 0;
	%do i = 1 %to %sysfunc(countw(&Face.));
		%local Face&i.;		
		%let Face&i. = %scan(&Face., &i., %str(,));
		%if &i. = 1 %then %do;
			%let FaceSort = Face&i.;
		%end;
		%else %do;
			%let FaceSort = &FaceSort., Face&i.;
		%end;
	%end;

	/* sort the array */	
	%syscall sortn(&FaceSort.);
	%put ============;
	%do i = 1 %to %sysfunc(countw(&Face.)); 		
		%put &&Face&i..;		
	%end;
	%put ============;
	
	%macro Greedy;	
		%local i Faces;
		%let Faces = %sysfunc(countw(&Face.));		
		%do %while(&Faces. >= 1);
			%put ===========================;
				%do %while(&Money. >= &&Face&Faces.. );	
				/* for repeated coin change. */
					%let Money = %eval(&Money. - &&Face&Faces..);				
					%let totalN = %eval(&totalN. + 1);		
					%put &&Face&Faces..;
					/* 
					for no repeated coin change.
					%let Faces = %eval(&Faces. - 1);
					%if &Faces. <= 0 %then %do;
						%goto EXITDO;
					%end; */
				%end;			
			%put ===========================;
			%let Faces = %eval(&Faces. - 1);
		%end;
			%EXITDO:
	%mend Greedy;
		
	%Greedy
	%put ============;
	%put &totalN.;
	%put ============;
	
%Mend CallGreedy;
%CallGreedy(Face = %nrbquote(1, 5, 10, 10, 9, 20), Money = 41)

/* Small change change ----2 */

%Macro CallGreedy(Face = , Money = );

	%local i FaceSort  totalN;	
	%let FaceSort =;	
	%let totalN    = 0;
	%do i = 1 %to %sysfunc(countw(&Face.));
		%local Face&i.;		
		%let Face&i. = %scan(&Face., &i., %str(,));
		%if &i. = 1 %then %do;
			%let FaceSort = Face&i.;
		%end;
		%else %do;
			%let FaceSort = &FaceSort., Face&i.;
		%end;
	%end;

	/* sort the array */	
	%syscall sortn(&FaceSort.);
	%put ============;
	%do i = 1 %to %sysfunc(countw(&Face.)); 		
		%put &&Face&i..;		
	%end;
	%put ============;
	
	%macro Greedy;	
		%local i Faces;
		%let Faces = %sysfunc(countw(&Face.));		
		%do i = &Faces. %to 1 %by -1;			
			%if &Money. < &&Face&i.. %then %do;
				%goto EXITDO;
			%end;			
			%put ===========================;				
				/* for repeated coin change. */
				%let Money = %eval(&Money. - &&Face&i..);				
				%let totalN = %eval(&totalN. + 1);		
				%put &&Face&i..;			
				%let i = &Faces.;
			%put ===========================;
							
			%EXITDO:
		%end;
			
	%mend Greedy;
		
	%Greedy
	%put ============;
	%put &totalN.;
	%put ============;
	
%Mend CallGreedy;
%CallGreedy(Face = %nrbquote(1, 5, 10, 10, 9, 20), Money = 41)


/* Small change change ----3 */

%Macro CallGreedy(Face = , Money = );

	%local i FaceSort  totalN;	
	%let FaceSort =;	
	%let totalN    = 0;
	%do i = 1 %to %sysfunc(countw(&Face.));
		%local Face&i.;		
		%let Face&i. = %scan(&Face., &i., %str(,));
		%if &i. = 1 %then %do;
			%let FaceSort = Face&i.;
		%end;
		%else %do;
			%let FaceSort = &FaceSort., Face&i.;
		%end;
	%end;

	/* sort the array ---- decending the sort */			
	/* %syscall sortn(&FaceSort.); */
	
	%local j k;
	
	/* bubble sort  */	
	%do i = 1 %to %sysfunc(countw(&Face.)) -1;	
		%do j = %sysfunc(countw(&Face.)) %to %eval(&i. + 1) %by -1;	 
			%let k = %eval(&j. - 1);
			%if &&Face&j.. > &&Face&k.. %then %do;
				%local TempVar;				
				%let TempVar = &&Face&j..;
				%let Face&j. = &&Face&k..;
				%let Face&k. = &TempVar.;				
			%end;
		%end;				
	%end;
	
	%put ============;
	%do i = 1 %to %sysfunc(countw(&Face.)); 		
		%put &&Face&i..;		
	%end;
	%put ============;
	
	%macro Greedy;	
		%local i Faces;
		%let Faces = %sysfunc(countw(&Face.));		
		%let i = 1;
		%do %while( &i. <= &Faces.);
		
			%if &Money. < &&Face&i.. %then %do;
				%let i = %eval(&i. + 1);
				%goto EXITDO;
			%end;	
			
			%put ===========================;						
				%let Money  = %eval(&Money. - &&Face&i..);				
				%let totalN = %eval(&totalN. + 1);		
				%put &&Face&i..;						
			%put ===========================;
			
			%EXITDO:
		%end;
			
	%mend Greedy;
		
	%Greedy
	
	%put ============;
	%put &totalN.;
	%put ============;
	
%Mend CallGreedy;

%CallGreedy(Face = %nrbquote(1, 5, 10, 10, 9, 20), Money = 41)


