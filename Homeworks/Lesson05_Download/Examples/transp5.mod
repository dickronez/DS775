// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

// simplified with only one product

{string} Cities = ...;
float Capacity = ...;

tuple tableRoutesType { 
  string o; 
  string d; 
  float cost; 
}
{tableRoutesType} TableRoutes = ...;

tuple connection { 
  string o; 
  string d; 
}

{connection} Connections = { <o,d> | <o,d,c> in TableRoutes };

float Supply[Cities] = ...;
float Demand[Cities] = ...;

float Cost[Connections] = [ <t.o,t.d>:t.cost | t in TableRoutes];


assert sum( s in Cities ) Supply[s] == sum( d in Cities) Demand[d];

dvar float+ Trans[Connections];   

constraint ctSupply[Cities];
constraint ctDemand[Cities];

minimize
  sum( c in Connections ) Cost[c] * Trans[c];
   
subject to {
  forall( o in Cities ) 
      ctSupply[o]: 
        sum( <o,d> in Connections ) 
          Trans[<o,d>] == Supply[o];
    forall( d in Cities ) 
      ctDemand[d]:  
        sum( <o,d> in Connections ) 
          Trans[<o,d>] == Demand[d];
    forall( c in Connections )
      ctCapacity: 
          Trans[c] <= Capacity;
}


