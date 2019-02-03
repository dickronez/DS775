/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: January 15, 2018
 *********************************************/

 {string} Foods = {"Steaks","Potatoes"}; 
 {string} Nutrients = {"Carbs","Protein","Fat"}
 
 /* fill in correct numbers */
 float CostPerServing[ Foods ] = [X, X];
 float NutrientsPerServing[ Nutrients ][ Foods ] = 
       [ [   X,  X],  /* Carbs */
         [   X,  X],  /* Protein */
         [   X,  X] ];/* Fat, coefficients negative for replacing 
                         15 S + 2 P <= 60 by
                        -15 S - 2 P >= -60 
                         to make the constraints all >= */
 float MinNutrients[ Nutrients ] = [X, X, X];

 constrain ctMinNutrients[Nutrients];
 
 dvar float+ Servings[Foods];
 
/* complete the definition of the objective function */
 minimize sum(f in Foods) XXX;

 subject to {
    forall( n in Nutrients )
    ctMinNutrients[n]:
	sum( f in Foods) XXX; /* complete the constraint here */
}

/* post processing output */
execute{
	writeln("Optimal Cost: ", cplex.getObjValue());
	writeln("Optimal Servings: ");
	for (var f in Foods)
	{
		writeln("Servings of ",f," = ",Servings[f]);
    }		
    
    writeln("Dual Solution: ");
    write("y=[");
    for (var n in Nutrients)
    {
    	write(ctMinNutrients[n].dual, " ")
    }
    writeln("]")    	    
}
