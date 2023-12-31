# How to use:

## Step 1: Install MiniZinc IDE
You can use this link https://www.minizinc.org/software.html

## Step 2: Open MiniZinc IDE + project files
Start the MiniZinc IDE
On the top right, select "open" and select both `HexPuzzleSolver.mzn` (source file) and `HexPuzzleExample.dzn` (input file)

## Step 3: Run it
On the top, select "Run", the output will appear on the bottom once it finds a solution.
You can change how many solutions to obtain by selecting in the top-right "Show configuration editor" -> "Options" -> "Solving" -> "User defined behaviour" -> "Satisfaction problems" -> "Stop after this many solutions"

# Representaton of the input:
Each value will be an integer, representing the length of that conection:
- Zero means that the edge is flat
- Positive values means that it sticks out, the larger the value, the longer the stick
- Negative values means that there is a hole, the larger the value, the deeper the hole
A connection can be made if the sum of two edges is less or equal than 0 (in other words, if there is a stick, the stick is shorter or equal to the length of the hole)

The input will be a .dzn file with two fields
An array of 18 numbers called "Border" which details the length of each hole/stick in the border. See from the image `HexNumbering.png` the red dots to see which index corresponds to which position
A matrix of of 7 rows and 6 columns of numbers called "Tiles". The row represents the number of the tile (first row being tile0) with each value inside the row detailing the length of each edge. See `HexNumbering.png` the purple dots to see which index corresponds to which position.

Example of the input:
```
Border = [-1,0,0,2,0,3,0,0,0,0,0,0,0,0,0,0,0,0];
Tiles =  [|1,0,0,0,0,0,
          |-3,0,-2,0,0,0,
          |0,0,0,0,0,0,
          |0,0,0,0,0,0,
          |0,0,0,0,0,0,
          |0,0,0,0,0,0,
          |0,0,0,0,0,0|]
```

# Representation of the output:
The output will be represented with three fields
An array of 7 elements called `TileAssignments` which details which tile goes in each position. See from the image `HexNumbering.png` the blue numbers to see what each index corresponds to. Example: Having `TileAssignments=[1,...]` means that tile1 has been placed where the blue 0 is in the image.
An array of 7 elements called `Rotations` which indicates the rotation of the tile on each position. The index corresponds to the position on the board (the blue numbers in the image `HexNumbering.png`) and the value indicates how many times the tile has been rotated 60º anti-clockwise. Another way of viewing it is that whatever edge was on position `value` of the original tile is now oriented on edge 0 of the placed tile (see purple numbers from `HexNumbering.png`)
An array of 7 elements called `Flips` which indicates whether the tile has been flipped or not (first apply rotation, and THEN apply flip). The axis of this flip is from the diagonal that goes from top-left to bottom-right. A value of false means it has NOT been flipped, a value of true means that is HAS been flipped

Example of the optput:
```
TileAssignments = [0, 1, 6, 5, 4, 3, 2];
Rotations = [0, 3, 0, 0, 0, 0, 0];
Flips = [false, true, false, false, false, false, false]
```

# Preview of `HexNumbering.png`
![HexNumbering](https://github.com/AlexDeAguiar/HexPuzzle/assets/73059426/857ca2c7-e3ae-4c27-9598-d08cdac5ed43)
