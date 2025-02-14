# Mastermind Game

## How to run the game
To start the game simply type "make run" into the terminal.

## How to play
The goal of the game is to guess the secret 4-color code within 10 guesses.
There are 8 possible colors: 
R(red), O(orange), Y(yellow), G(green), B(blue), P(purple), W(white), Z(zlack (ran out of letters)).
Duplicates ARE allowed.

By default, the code is "R O Y Y", but if the player enters "rand" as their first guess, the code randomizes
and the game starts over.

After each guess, the player is notified on how many of the colors in their guess are correct or misplaced.
When all 4 colors of the player's guess match the code, the player wins!
