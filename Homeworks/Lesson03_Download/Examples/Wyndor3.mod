/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Jun 22, 2016 at 4:32:37 PM
 *********************************************/

 {string} Products = {"Doors","Windows"};
 {string} Plants = {"Plant1","Plant2","Plant3"};
 
 float ProfitPerBatch[Products] = [3,5];
 float HoursUsedPerBatch[Plants][Products] = [ [1,0], [0,2], [3,2] ];
 float MaxProductionHours[Plants] = [4,12,18];

 constraint ctMaxHours[Plants];
 
 dvar float+ Batches[Products];
 
 maximize
 	sum( p in Products )
 	  ProfitPerBatch[p] * Batches[p];
subject to {
  forall( pl in Plants )
    ctMaxHours[pl]:
    sum( p in Products )
      HoursUsedPerBatch[pl][p] * Batches[p] <= MaxProductionHours[pl];
}

/* post processing output */
execute{
	writeln("Optimal Profit: ", cplex.getObjValue());
	writeln("Optimal Decision Variable Values: ");
	for (var p in Products)
	{
		writeln("Batches of ",p," = ",Batches[p]);
    }		
    
    writeln("Dual Solution: ");
    write("y=[");
    for (var pl in Plants)
    {
    	write(ctMaxHours[pl].dual, " ")
    }
    writeln("]")    	    
}
