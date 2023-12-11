include "globals.mzn";
include "alldifferent.mzn";

%Constants
int: MaxLength = 5;

%Input Representation
array[1..18] of -MaxLength..MaxLength: Border;

array[1..7, 1..6] of -MaxLength..MaxLength: Tiles;

%Output Representation
array[1..7] of var 0..6: TileAssignments;

array[1..7] of var 0..5: Rotations;

array[1..7] of var bool: Flips;

%Can only use each tile once
constraint alldifferent(TileAssignments);

%Match connections with border
constraint forall(i in 0..17) (Border[i + 1] + Tiles[TileAssignments[(i div 3) + 1] + 1, (((((((((i div 3) + (i mod 3)) mod 6) * (if Flips[(i div 3) + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[(i div 3) + 1]) mod 6) + 1)] <= 0);

%Match connections with center
constraint forall(i in 0..5) ((Tiles[TileAssignments[i + 1] + 1, ((((((((i + 4) mod 6) * (if Flips[i + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[i + 1]) mod 6) + 1)]) + (Tiles[TileAssignments[6 + 1] + 1, ((((((((i + 1) mod 6) * (if Flips[6 + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[6 + 1]) mod 6) + 1)]) <= 0);


%Match connections with sides (TODO)
constraint forall(i in 0..5) ((Tiles[TileAssignments[i + 1] + 1, ((((((((i + 5) mod 6) * (if Flips[i + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[i + 1]) mod 6) + 1)])
+ (Tiles[TileAssignments[((i + 5) mod 6) + 1] + 1, ((((((((i + 2) mod 6) * (if Flips[((i + 5) mod 6) + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[((i + 5) mod 6) + 1]) mod 6) + 1)]) <= 0);


solve satisfy;



%How to obtain length on a given position
%Tiles[TileAssignments[tilePositionFrom0To6 + 1] + 1, (((((((stickFrom0To5 mod 6) * (if Flips[tilePositionFrom0To6 + 1] then -1 else 1 endif)) + 6) mod 6) + Rotations[tilePositionFrom0To6 + 1]) mod 6) + 1)]


