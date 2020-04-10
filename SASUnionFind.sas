/**********************************************************************************************************
 * Macro Name        : Union find                                                                                 
 * Purpose           : Union find.                                      
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

%Macro CallUnionFind_FIND(Num = );
	
	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
		
	%macro UnionFind_FIND(Num = );		
		
		%Initialize
		/* The find macro */
		/* Return the root node */
		%macro Find(N);
			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			%Returnvalue: &&Parent&N..
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			%local j;
			%do j = 1 %to &Num.;
				%if &&Parent&j.. = &P1. %then %do;
					%let Parent&j. = &P2.;
				%end;
			%end;
		%mend Union;

	%mend UnionFind_FIND;
	%UnionFind_FIND(Num = &Num.)
	
	%macro print;
		%local i Array Parents;
		%let Parents =;
		%let Array =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;			
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Parents.;
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
%Mend CallUnionFind_FIND;

%CallUnionFind_FIND(Num = 10)

/* Improving the algorithm--Union */

%Macro CallUnionFind_UNION(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
		
	%macro UnionFind_UNION(Num = );		
		
		%Initialize
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			
			%do %while(&N. ne &&Parent&N..);
				%let N = &&Parent&N..;
			%end;
			
			%Returnvalue: &&Parent&N..
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%let Parent&P1. = &P2.;
			
		%mend Union;

	%mend UnionFind_UNION;
	%UnionFind_UNION(Num = &Num.)
	
	%macro print;
		%local i Array Parents;
		%let Parents =;
		%let Array =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;			
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Parents.;
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
		
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_UNION;

%CallUnionFind_UNION(Num = 10)

/* Improving the algorithm--Size */

%Macro CallUnionFind_SIZE(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
	
	/* Initialize the size for each ROOT NODE */
	%macro InitializeSize;
		%local i;
		%do i = 1 %to &Num.;
			%global Size&i.;
			%let Size&i. = 1;
		%end;		
	%mend InitializeSize;
		
	%macro UnionFind_SIZE(Num = );		
		
		%Initialize
		%InitializeSize	
		
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			
			%do %while(&N. ne &&Parent&N..);
				%let N = &&Parent&N..;
			%end;
			
			%Returnvalue: &&Parent&N..
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%if &&Size&P1.. < &&Size&P2.. %then %do;
				%let Parent&P1. = &P2.;
				%let Size&P2. = %eval(&&Size&P2.. +  &&Size&P1..);
			%end;
			%else %do;
				%let Parent&P2. = &P1.;
				%let Size&P1. = %eval(&&Size&P1.. +  &&Size&P2..);
			%end;
						
		%mend Union;

	%mend UnionFind_SIZE;
	%UnionFind_SIZE(Num = &Num.)
	
	%macro print;
		%local i Array Parents Size;
		%let Parents =;
		%let Array =;
		%let Size =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;		
			%let Size = &Size. &&Size&i..;	
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Size.;
		%put &Parents.;		
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
		
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_SIZE;

%CallUnionFind_SIZE(Num = 10)

/* Improving the algorithm--Rank */

%Macro CallUnionFind_RANK(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
	
	/* Initialize the Rank for each ROOT NODE */
	%macro InitializeRank;
		%local i;
		%do i = 1 %to &Num.;
			%global Rank&i.;
			%let Rank&i. = 1;
		%end;		
	%mend InitializeRank;
		
	%macro UnionFind_RANK(Num = );		
		
		%Initialize
		%InitializeRank	
		
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			
			%do %while(&N. ne &&Parent&N..);
				%let N = &&Parent&N..;
			%end;
			
			%Returnvalue: &&Parent&N..
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%if &&Rank&P1.. < &&Rank&P2.. %then %do;
				%let Parent&P1. = &P2.;
			%end;
			%else %if &&Rank&P1.. > &&Rank&P2.. %then %do;
				%let Parent&P2. = &P1.;			
			%end;
			%else %do;
				%let Parent&P1. = &P2.;
				%let Rank&P2. = %eval(1 +  &&Rank&P2..);
			%end;
						
		%mend Union;

	%mend UnionFind_RANK;
	%UnionFind_RANK(Num = &Num.)
	
	%macro print;
		%local i Array Parents Rank;
		%let Parents =;
		%let Array =;
		%let Rank =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;		
			%let Rank = &Rank. &&Rank&i..;	
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Rank.;
		%put &Parents.;		
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
	
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_RANK;

%CallUnionFind_RANK(Num = 10)

/* Improving the algorithm--Path Compression */

%Macro CallUnionFind_PathC(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
	
	/* Initialize the Rank for each ROOT NODE */
	%macro InitializeRank;
		%local i;
		%do i = 1 %to &Num.;
			%global Rank&i.;
			%let Rank&i. = 1;
		%end;		
	%mend InitializeRank;
		
	%macro UnionFind_PathC(Num = );		
		
		%Initialize
		%InitializeRank	
		
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			
			%if &&Parent&N.. ne &N. %then %do;
				%let Parent&N. = %Find(&&Parent&N..);
			%end;
			%Returnvalue: &&Parent&N..
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%if &&Rank&P1.. < &&Rank&P2.. %then %do;
				%let Parent&P1. = &P2.;
			%end;
			%else %if &&Rank&P1.. > &&Rank&P2.. %then %do;
				%let Parent&P2. = &P1.;			
			%end;
			%else %do;
				%let Parent&P1. = &P2.;
				%let Rank&P2. = %eval(1 +  &&Rank&P2..);
			%end;
						
		%mend Union;

	%mend UnionFind_PathC;
	%UnionFind_PathC(Num = &Num.)
	
	%macro print;
		%local i Array Parents Rank;
		%let Parents =;
		%let Array =;
		%let Rank =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;		
			%let Rank = &Rank. &&Rank&i..;	
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Rank.;
		%put &Parents.;		
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
	
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_PathC;

%CallUnionFind_PathC(Num = 10)

/* Improving the algorithm--Path Spliting */

%Macro CallUnionFind_PathS(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
	
	/* Initialize the Rank for each ROOT NODE */
	%macro InitializeRank;
		%local i;
		%do i = 1 %to &Num.;
			%global Rank&i.;
			%let Rank&i. = 1;
		%end;		
	%mend InitializeRank;
		
	%macro UnionFind_PathS(Num = );		
		
		%Initialize
		%InitializeRank	
		
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			%do %while(&N. ne &&Parent&N..);
				%local P;
				%let P = &&Parent&N..;
				%let Parent&N. = &&Parent&P..;
				%let N = &P.;
			%end;
			
			%Returnvalue: &N.
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%if &&Rank&P1.. < &&Rank&P2.. %then %do;
				%let Parent&P1. = &P2.;
			%end;
			%else %if &&Rank&P1.. > &&Rank&P2.. %then %do;
				%let Parent&P2. = &P1.;			
			%end;
			%else %do;
				%let Parent&P1. = &P2.;
				%let Rank&P2. = %eval(1 +  &&Rank&P2..);
			%end;
						
		%mend Union;

	%mend UnionFind_PathS;
	%UnionFind_PathS(Num = &Num.)
	
	%macro print;
		%local i Array Parents Rank;
		%let Parents =;
		%let Array =;
		%let Rank =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;		
			%let Rank = &Rank. &&Rank&i..;	
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Rank.;
		%put &Parents.;		
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
	
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_PathS;

%CallUnionFind_PathS(Num = 10)

/* Improving the algorithm--Path Halving */

%Macro CallUnionFind_PathH(Num = );

	/* Initialize the unionfind */
	%macro Initialize;
		%local i;	
		%do i = 1 %to &Num.;
			%global Parent&i.;
			%let  Parent&i. = &i.;	
		%end;
	%mend Initialize;
	
	/* Initialize the Rank for each ROOT NODE */
	%macro InitializeRank;
		%local i;
		%do i = 1 %to &Num.;
			%global Rank&i.;
			%let Rank&i. = 1;
		%end;		
	%mend InitializeRank;
		
	%macro UnionFind_PathH(Num = );		
		
		%Initialize
		%InitializeRank	
		
		/* The find macro */
		/* Return the root node */
		%macro Find(N);

			%if &N. < 1 or &N. > &Num. %then %do;
				%put N is not in the RANGE.;
				%return;
			%end;
			%do %while(&N. ne &&Parent&N..);
				%local P;
				%let P = &&Parent&N..;
				%let Parent&N. = &&Parent&P..;
				%let N = &&Parent&N..;
			%end;
			
			%Returnvalue: &N.
			
		%mend Find;
		/* The union macro */
		/* Union N1 parents to N2 */
		%macro  Union(N1, N2);		
			%local P1 P2;
			%let P1 = %Find(&N1.);
			%let P2 = %Find(&N2.);
			
			%if &P1. = &P2. and %length(&P1.) > 0 %then %do;
				%return;
			%end;
			
			%if &&Rank&P1.. < &&Rank&P2.. %then %do;
				%let Parent&P1. = &P2.;
			%end;
			%else %if &&Rank&P1.. > &&Rank&P2.. %then %do;
				%let Parent&P2. = &P1.;			
			%end;
			%else %do;
				%let Parent&P1. = &P2.;
				%let Rank&P2. = %eval(1 +  &&Rank&P2..);
			%end;
						
		%mend Union;

	%mend UnionFind_PathH;
	%UnionFind_PathH(Num = &Num.)
	
	%macro print;
		%local i Array Parents Rank;
		%let Parents =;
		%let Array =;
		%let Rank =;
		%do i = 1 %to &Num.;
			%let Array = &Array. &i.;
			%let Parents = &Parents. &&Parent&i..;		
			%let Rank = &Rank. &&Rank&i..;	
		%end;
		%put;
		%put ==================================;
		%put &Array.;
		%put &Rank.;
		%put &Parents.;		
		%put ==================================;
		%put;
	%mend print;
	
	
	/* Testing  1*/
	%print
	
	/* Testing  2*/
	%Union(1, 2)	
	%print
	
	/* Testing  3*/
	%Union(2, 3)	
	%print
	
	/* Testing  4*/
	%Union(4, 1)	
	%print
	
	/* Testing  4*/
	%Union(6, 4)	
	%print
%Mend CallUnionFind_PathH;

%CallUnionFind_PathH(Num = 10)

