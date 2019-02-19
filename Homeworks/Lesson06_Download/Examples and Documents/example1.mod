/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Aug 29, 2016 at 4:16:48 PM
 *********************************************/
 using CP;
 
 range R = 1..4;
 dvar int x[R] in 1..5;
 
 subject to {
 	ct1:
 		allDifferent(x);
 	ct2: 
 		x[1] + x[3] == 4;
    ct3: 
    	x[1] <= 2;
    ct4:
    	x[2] <= 2;
    ct5: 
    	x[3] <= 3;
 }