/*********************************************
* prototype example from page 476
* simple implementation
 *********************************************/
// 

dvar boolean x[1..4];

maximize 9*x[1] + 5*x[2] + 6*x[3] + 4*x[4];

subject to{
ct1:  
	6*x[1] + 3*x[2] + 5*x[3] + 2*x[4] <= 10;
ct2: 
	x[3] + x[4] <= 1;
ct3: 
	-x[1] + x[3] <= 0;
ct4:
	-x[2] + x[4] <= 0;
};

