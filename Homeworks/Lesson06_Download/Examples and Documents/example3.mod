/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Sep 12, 2016 at 2:41:59 PM
 *
 * Example to solve
 * 
 * maximize 10*x1 + 2*x2 - x3^2  (note: nonlinear is OK here)
 * 
 * with constraints
 * x1, x2, and x3 are all different
 * 
 * x1 in {10,20,30}
 * x2 in {20,30,40}
 * x3 in {10,30,50}
 *********************************************/

using CP;

int x[1..5] = [10,20,30,40,50];
dvar int p[1..3] in 1..5;

maximize 10*x[p[1]] + 2*x[p[2]] - x[p[3]]^2;


subject to {
	ct1:
		allDifferent(p);
    ct2: // constrain x1 = x[p[1]] to be in {10,20,30}
    	p[1]>=1 && p[1]<=3;
    	// p[1] <= 3 would also work by itself
    ct3: // constrain x2 = x[p[2]] to be in {20,30,40}
    	p[2]>=2 && p[2]<=4;
    ct4:  // constrain x3 = x[p[3]] to be in {10,30,50}
    	p[3]==1  || p[3]==3 || p[3]==5;   
}

execute{
	writeln('x1 is ',x[p[1]]);
	writeln('x2 is ',x[p[2]]);
	writeln('x3 is ',x[p[3]]);
}