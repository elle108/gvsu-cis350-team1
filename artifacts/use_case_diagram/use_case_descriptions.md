# Play Game

Actor: Player

Description: The player is able to select the play game if they log in. Playing the game involves the activities of moving the character, the ability to shoot asteroids, and the ability to earn points.

Requirements: To have an account and be logged in.

Use Cases: Player needs to have completed the Log in use case
 
# Shoot Asteroids

Actor: Player

Description: The player is able to shoot asteroids by aiming and pressing the designated firing button. The direction the bullet is shot is determined by the direction the character is facing. Shooting the asteroid with the correct answer on it results in earning points. Shooting the incorrect answer results in losing a life.

Requirements: To have an account and be logged in. The player must initiate playing the game.

Use Cases: The Player needs to complete the log in and play game use cases. 

# Earn Points

Actor: Player

Description: The player earns points upon shooting the asteroid with the correct answer on it. The resulting score is based upon how fast the player shoots the correct answer. The faster they shoot the correct answer, the higher the point value is for solving that problem.

Requirements: The player needs to be logged in and playing the game.

Use Cases: The Player needs to complete the log in and play game use cases. 

# Move Character

Actor: Player

Description: The player is placed on the map. The player is able to use the arrow keys to change direction and also move diagonally by holding 2 directions at once, like up and left to move to the upper left. If the player moves into the wall, they are stopped from moving anymore in that direction.

Requirements: The player needs to be logged in and playing the game.

Use Cases: The Player needs to complete the log in and play game use cases. 

# Select Level

Actor: Player

Description: The player is able to select the level of the game. The higher the level is, the math will be more difficult, more asteroids will appear on screen per problem, and the asteroids will move faster. 

Requirements: The player needs to be logged in and playing the game.

Use Cases: The Player needs to complete the log in and play game use cases.

# View Leaderboard

Actor: Player

Description: The leaderboard is where high scores can be found for each level. The player is able to view the leaderboard per level for that math subject.

Requirements: None

Use Cases: None

# Log in

Actor: Player

Description: This is where a player can login for their game progress and game scores to be saved. The Login will check for appropriate usernames and passwords.

Requirements: The player needed to have an account in order to log in.

Use Cases: The player needs to complete the create account use case if they did not already have an account.

# Create Account

Actor: Player

Description: A player is directed here if they do not have an account. They will be required to make a unique username and password. The username and password will be checked for appropriateness.

Requirements: Both the username and password must be appropriate. The password must be at least 8 characters long.

Use Cases: None

# Select Font

Actor: Player

Description: On the main menu the player is able to hit a select font button that will change the appearance of the font on the game. One option is a basic font. Another option is a dyslexic friendly font. 

Requirements:  There must be font options that include dyslexic friendly font options.

Use Cases: None

# Select Color-Schema

Actor: Player

Description: On the main menu the player is able to hit a select color-schema option. It will cycle through options that includes dark mode, light mode, and colorblind friendly options.

Requirements: None

Use Cases: None

# Complete Level

Actor: Player

Description: Once the player earns a certain number of points that meets or beats that level’s threshold, the player completes the level. After a level is completed, the game’s difficulty increases.

Requirements: The player must earn certain number of points to reach the point threshold that they pass the level. 

Use Cases: The player must have completed the play game and earn points use cases.

# Save Score

Actor: Player, Game System

Description: The Game system saves the score of the player for that level. If the score is higher than other scores on the leaderboard, the player’s score will show on the leaderboard for that level.

Requirements:  The player needs to have completed a level. The game system needs a score in order to save the score.

Use Cases: The player needs to have completed the use cases of play game, earn points, and  complete level.

# Spawn Asteroids

Actor: Game System

Description: The game system takes in the current level of the game and uses that to determine the number of asteroids spawned and the speed of the asteroids for a given level.

Requirements: The game must be open for the game system to spawn asteroids.

Use Cases: None

# Display Gamer Information

Actor: Game System

Description: The game system displays relevant information to the player. The information displayed includes the current level, the gamer’s name, the current number of lives, the time elapsed, and the current math problem. 

Requirements: The game needs to be running for the Game System to display information. 

Use Cases: None

# Track Time

Actor: Game System

Description: The Game system will track time elapsed during each level. This is used to determine the score a player gets for shooting the correct asteroid. 

Requirements: The game needs to be running for the Game System to track time 

Use Cases: None