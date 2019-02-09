/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Feb 7, 2019
 *********************************************/
 
// Initialize data from file
{string} Warehouses = ...;
{string} Stores = ...;
float Capacity = ...;
 
tuple ConnectionsCostType {
 string w;
 string s;
 float c;
}

{ConnectionsCostType} ConnectionsCosts = ...;
 
float Supply[Warehouses] = ...;
float Demand[Stores] = ...;

tuple ConnectionType {
  string w;
  string s;
}

// strip the warehouse to store connections from the ConnectionsCosts tuples 
{ConnectionType} Connections = { <w,s> | <w,s,c> in ConnectionsCosts };

// build a vector Cost indexed by Connections so that 
// Cost[ <w,s> ] gives the cost associated with shipping 
// per unit along that connection.
// t is just a loop variable here and can be named anything
float Cost[Connections] = [ <t.w,t.s>:t.c | t in ConnectionsCosts ];

dvar float+ Transport[Connections];

minimize sum( k in Connections) Cost[ k ]*Transport[ k ];
// or like this
// minimize sum( <w,s> in Connections ) Cost[<w,s>]*Transport[<w,s>];

constraint ctFromWarehouse[Warehouses];
constraint ctToStore[Stores];

subject to {
  forall( w in Warehouses )
    ctFromWarehouse[w]: // the total shipped from warehouse w must equal supply
      sum( <w,s> in Connections )
        Transport[ <w,s> ] == Supply[w];
  forall( s in Stores ) // total shipped to store equals demand
    ctToStore[s]:
      sum( <w,s> in Connections )
        Transport[ <w,s> ] == Demand[s];
  forall( k in Connections )
    ctMaxShipment:
      Transport[ k ] <= Capacity;
}
