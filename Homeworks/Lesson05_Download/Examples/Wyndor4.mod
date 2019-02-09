/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Jun 22, 2016 at 4:32:37 PM
 *********************************************/

 {string} Products = ...;
 {string} Plants = ...;
 
 float ProfitPerBatch[Products] = ...;
 float HoursUsedPerBatch[Plants][Products] = ...;
 float MaxProductionHours[Plants] = ...;
 
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
