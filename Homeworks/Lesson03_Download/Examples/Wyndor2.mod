/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Jun 22, 2016 at 4:32:37 PM
 *********************************************/

/* Set parameters */
 int NbProducts = 2;
 int NbPlants = 3;
 
 range Products = 1..NbProducts;
 range Plants = 1..NbPlants;

 float ProfitPerBatch[Products] = [3,5];
 float HoursUsedPerBatch[Plants][Products] = [ [1,0], [0,2], [3,2] ];
 float MaxProductionHours[Plants] = [4,12,18];
 
/* decision variables, note the + says is a positivity constraint */ 
 dvar float+ Batches[Products];
 
 /* objective */
 maximize
 	sum( p in Products )
 	  ProfitPerBatch[p] * Batches[p];
/* constraints */ 	  
subject to {
  forall( pl in Plants )
    ctMaxHours[pl]:
    sum( p in Products )
      HoursUsedPerBatch[pl][p] * Batches[p] <= MaxProductionHours[pl];
}

/* post processing output */
execute{
	writeln("Optimal Value: ", cplex.getObjValue());
	writeln("Primal Soutions: ");
	write("Batches=[")
	for (var p in Products)
	{
		write(Batches[p]," ");
    }
    writeln("]")			
    
    writeln("Dual Solution: ");
    write("y=[");
    for (var pl in Plants)
    {
    	write(ctMaxHours[pl].dual, " ")
    }
    writeln("]")    	    
}
