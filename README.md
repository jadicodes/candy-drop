# Candy Drop
[Play here!](https://prismatoad.itch.io/candy-drop)

In Candy Drop, drop different colors of candies on top of each other to create bigger candies! Try to reach the near-impossible double jawbreaker!

## Reflection
By far, my biggest struggle with this project was figuring out how to handle candy collision creating new candies. At first, it
would create infinite candies because two would create two, and then those two would create two more, and it was a whole mess.
The problem stems from both candies having the same collision tracker, and both candies wanting to make a new candy when they collide.
I solved this problem by creating a boolean variable inside of each candy that tracks whether one has been collided with or not, so that the function that creates the candy
is only called once, not twice per interaction.
