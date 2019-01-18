/*********************************************
* solution to problem 12.3-4
* y1 and y2 are binary variables indicating whether or not toy 1 and toy 2 are produced
* x1 and x2 are the number of toys 1 and 2 that are produced
* z is zero if factory 1 is used or 1 if factory 2 is used.
* let M be a very large number
*
* maximize 10 x1 + 15 x2 - 50000 y1 - 80000 y2
*
* subject to
* x1 <= M y1
* x2 <= M y2
* 1/50 x1 + 1/40 x2 <= 500 + M z
* 1/40 x1 + 1/25 x2 <= 700 + M(1-z)
*
* x1 and x2 should be integers, but we'll leave them as real for now
* x1, x2 >= 0
* y1, y2, z binary
 *********************************************/
// 
dvar float+ x[1..2];
dvar boolean y[1..2];
dvar boolean z;
float M = 1000000;

maximize 10*x[1] + 15*x[2] - 50000*y[1] - 80000*y[2];

subject to{
	ct1:
		x[1] <= M*y[1];
	ct2:
		x[2] <= M*y[2];
	ct3:
		x[1]/50 + x[2]/40 <= 500 + M*z;
	ct4: 
		x[1]/40 + x[2]/25 <= 700 + M*(1-z);
};

