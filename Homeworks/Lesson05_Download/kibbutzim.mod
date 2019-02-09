/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Aug 3, 2016 at 10:19:00 AM
 *********************************************/
 int NumKibbutz = ...;
 range Kibbutz = 1..NumKibbutz;
 {string} Crops = ...;
 
 float WaterAlloc[Kibbutz] = ...;
 float UsableLand[Kibbutz] = ...;
 
 float NetReturn[Crops] = ...;
 float MaxQuota[Crops] = ...;
 float WaterConsume[Crops] = ...;
 
 dvar float+ Acres[Kibbutz][Crops];
 dexpr float LandTotal[k in Kibbutz] = sum(c in Crops) Acres[k][c];
 dexpr float CropTotal[c in Crops] = sum(k in Kibbutz) Acres[k][c];
 dexpr float WaterUsed[k in Kibbutz] = sum(c in Crops) WaterConsume[c]*Acres[k][c];
 dexpr float LandProp[k in Kibbutz] = LandTotal[k]/UsableLand[k];
 
 maximize
 	sum(c in Crops) 
 		NetReturn[c] * CropTotal[c];
 		
 subject to {
 	forall (k in Kibbutz)
 	  ctLand:
 	  	LandTotal[k] <= UsableLand[k];
	forall (k in Kibbutz)
	  ctWater:
	  	WaterUsed[k] <=  WaterAlloc[k];
  	forall (c in Crops)
  	  ctQuota:
  	    CropTotal[c] <= MaxQuota[c];
  	forall (ordered i,j in Kibbutz)
  	  ctProp:
  	  	LandProp[i] - LandProp[j] == 0;
}
 
 
/* post processing */

execute{
	writeln("Optimal: ", cplex.getObjValue());
	writeln('Kibbutz, Crop, Acres, Reduced Cost')
	for (var k in Kibbutz)
	{
		for (var c in Crops)
		{
			writeln(k,', ',c,', ',', ',Acres[k][c],', ',Acres[k][c].reducedCost);
		}
	}	
	for (var k in Kibbutz)
	{
		writeln(ctLand[k].name,", ",LandTotal[k],', ',ctLand[k].dual,', ',UsableLand[k],', ',
			ctLand[k].UB,', ', ctLand[k].LB )	
	}
	for (var k in Kibbutz)
	{
		writeln(ctWater[k].name,", ",WaterUsed[k],', ',ctWater[k].dual,', ',WaterAlloc[k],', ',
			ctWater[k].UB,', ', ctWater[k].LB )	
	}					
}