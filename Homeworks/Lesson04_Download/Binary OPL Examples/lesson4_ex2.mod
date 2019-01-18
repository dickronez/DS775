/*********************************************
* prototype example from page 476
* flexible implementation that allows for expansion and easy changes
 *********************************************/
// 

float objCoef[1..4] = [9,5,6,4];
float ctCoef[1..4][1..4] = [ [6,3,5,2], [0,0,1,1], [-1,0,1,0], [0,-1,0,1] ];
float ctRhs[1..4] = [10,1,0,0];

dvar boolean x[1..4];

constraint ctall[1..4];

maximize sum(j in 1..4) objCoef[j]*x[j];

subject to{
	forall (i in 1..4)  
		ctall[i]:
			sum(j in 1..4) ctCoef[i][j]*x[j] <= ctRhs[i];
};

