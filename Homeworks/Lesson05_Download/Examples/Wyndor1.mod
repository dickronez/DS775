/*********************************************
 * OPL 12.6.3.0 Model
 * Author: jbaggett
 * Creation Date: Jun 22, 2016 at 4:13:02 PM
 *********************************************/

dvar float+ Doors; /* batches of doors */
dvar float+ Windows; /* batches of windows */

maximize /* profit per batch in thousands */
  3 * Doors + 5 * Windows;
subject to {
  ctPlant1Hours:
        Doors               <= 4;
  ctPlant2Hours:
                2 * Windows <= 12;
  ctPlant3Hours:
    3 * Doors + 2 * Windows <= 18;
}