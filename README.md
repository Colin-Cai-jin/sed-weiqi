# The game
The game `weiqi.sed` of weiqi(go) is write in GNU sed.

# Start game
After the program began to run, we must input `start` to start a new game.

# Play
We can input two numbers for the coordinate in a line to put a stone on the position of the board. Black and white are in turn.

# End the game
We can input `score` to lead the game to counting.  
In counting, we can input two numbers for the coordinate to clear the dead stones.  
After we cleared all the , we can input `end` to count the result. We use Chinese rules(3+3/4) because it is more simple than the others.  
At last, we can input a file name to save the chess manual to it. And, if the suffix of the file name is `sgf`, the program will save the chess manual in `sgf` format.
