/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Aug 29, 2016 at 4:16:48 PM
 *
 * Idea:  buy 0,1,2, or 3 advertising spots for 
 * for each of three products.  We want to maximize
 * additional profit z1 + z2 + z3, but added profit 
 * isn't proportional to the number of advertising spots. 
 * Also we are going to buy exactly 5 ad spots
 *
 * This is the constraint programming model
 * discussed on page 530 of Hillier and Liebermann.
 * 
 * Compare it to the binary variable formulations 
 * on pages 492-495.  This is MUCH simpler.
 *
 * element constraints are described on page 62
 * of the OPL language reference manual.
 *********************************************/
 
 using CP;
 
 range R = 1..3;
 dvar int x[R] in 0..3; // number of ad spots to buy for each product
 range Q = 1..4;
 int z1[Q] = [0,1,3,3]; // profit for product 1 for buying 0,1,2,3 ad spots
 int z2[Q] = [0,0,2,3]; // profit for product 2 ...
 int z3[Q] = [0,-1,2,4]; // profit for product 3 ...
 
 maximize z1[ x[1] + 1 ]+z2[ x[2] + 1 ]+z3[ x[3] + 1 ];
 
 subject to {
 	ct1:
		x[1]+x[2]+x[3]==5;
 }