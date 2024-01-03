include "globals.mzn";
include "alldifferent.mzn";

%Constants
int: MaxLength = 5;
  
%Output Representation-------------------------------------------------------------------------------------
array[0..17] of var -MaxLength..MaxLength: Border;
array[0..6, 0..5] of var -MaxLength..MaxLength: Tiles;

array[0..6] of var 0..6: TileAssignments;
array[0..6] of var 0..5: Rotations;
array[0..6] of var bool: Flips;

%Input Representation A (Comment this whole block to use a different one)------------------------------
% array[1..18] of -MaxLength..MaxLength: BorderIn =
%   [0,-1,0,0,-2,0,0,-3,0,0,-4,0,0,-5,0,0,1,0];

% array[1..7, 1..6] of -MaxLength..MaxLength: TilesIn =
%   [|-2,-1,2,0,1,0,
%   |-2,-2,2,0,2,0,
%   |-2,-3,2,0,3,0,
%   |2,-3,-2,0,4,0,
%   |-2,-2,2,0,5,0,
%   |-2,-1,2,0,-1,0,
%   |1,2,3,3,2,1|];
  
% constraint forall(i in 1..18) (BorderIn[i] = Border[i-1]);
% constraint forall(i in 1..7, j in 1..6) (TilesIn[i,j] = Tiles[i-1,j-1]);

%Input Representation B (Comment this whole block to use a different one)------------------------------
array[1..30] of -MaxLength..MaxLength: s =
  [-1, -1, 1, 0, -1, 1, -1, -1, 1, 1, 0, -1, 0, 1, -1, 1, 0, -1, 0, 1, -1, 1, -1, -1, -1, -1, 0, 1, 0, 0];

array[1..7, 1..6] of -MaxLength..MaxLength: sMap = 
  [|-s[1],  -s[2],  -s[3],   s[20],  s[25],  s[19],
   |-s[20], -s[4],  -s[5],  -s[6],   s[21],  s[26],
   | s[27], -s[21], -s[7],  -s[8],  -s[9],   s[22],
   | s[23],  s[28], -s[22], -s[10], -s[11], -s[12],
   |-s[15],  s[24],  s[29], -s[23], -s[13], -s[14],
   |-s[17], -s[18], -s[19],  s[30], -s[24], -s[16],
   |-s[30], -s[25], -s[26], -s[27], -s[28], -s[29]|];

constraint forall(i in 1..18) (s[i] = Border[i-1]);
constraint forall(i in 1..7, j in 1..6) (sMap[i,j] = Tiles[i-1,j-1]);

%Puzzle generation contraints (only when no input is provided)-----------------------------------------------

%Auxiliary functions---------------------------------------------------------------------------------------
function var int: positiveMod(var int: n, var int: d) = if (n > 0) then (n mod d) else (((n mod d) + d) mod d) endif;
function var bool: canFit(var -MaxLength..MaxLength: a, var -MaxLength..MaxLength: b) = (a + b) <= 0;
function var -MaxLength..MaxLength: applyRotationAndFlip(var 0..6: tilePos, var 0..5: stickPos) = positiveMod(if (Flips[tilePos]) then -(stickPos + Rotations[tilePos]) else (stickPos + Rotations[tilePos]) endif , 6);
function var -MaxLength..MaxLength: stick(var 0..6: tilePos, var 0..5: stickPos) = Tiles[TileAssignments[tilePos], applyRotationAndFlip(tilePos, stickPos)];

%Constraints-----------------------------------------------------------------------------------------------
%Can only use each tile once:
constraint alldifferent(TileAssignments);

%Match connections with the border:
constraint forall(i in 0..17) (canFit(Border[i], stick(i div 3, positiveMod((i div 3) + (i mod 3), 6))));

%Match connections with center:
constraint forall(i in 0..5) (canFit(stick(6, positiveMod(i + 1, 6)), stick(i, positiveMod(i + 4, 6))));

%Match connections with sides:
constraint forall(i in 0..5) (canFit(stick(i, positiveMod(i + 3, 6)), stick(positiveMod(i + 1, 6), i)));

solve satisfy;