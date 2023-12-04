include "globals.mzn";

%Constants
int: MaxLength = 5;

%Input Representation
array[1..18] of -MaxLength..MaxLength: Border;

array[1..7, 1..6] of -MaxLength..MaxLength: Tiles;

%Output Representation
array[1..7] of var 0..6: TileAssignments;

array[1..7] of var 0..5: Rotations;

array[1..7] of var bool: Flips;

%Match connectiopns with border
constraint forall(i in 0..17) (Border[i + 1] + Tiles[(i div 3) + 1, ( (((if Flips[(i div 3) + 1] then -1 else 1 endif) * ((i mod 3) + (i div 3) + Rotations[(i div 3) + 1])) + (if Flips[(i div 3) + 1] then 6 else 0 endif)) mod 6) + 1] <= 0);

solve satisfy;