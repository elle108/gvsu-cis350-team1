# Overview

This Software Requirements Specification (SRS) document defines the functional and non-functional requirements for Math-eroids, a math based educational game inspired by the classic Asteroids. The purpose of this document is to clearly describe what the software does, how it behaves, and the constraints under which it operates. This SRS reflects the final implemented version of the project and serves as a reference for development, testing, and evaluation.

# Software Requirements

This section outlines the required behavior and quality attributes of Math-eroids. Functional Requirements describe what the system must do, while Non-Functional Requirements describe how well the system must perform these functions.

## Functional Requirements

### Gameplay Mechanics

| ID  | Requirement |
| :--: | ----------- |
| FR1 | The system shall display a player controlled spaceship that can rotate without being propelled forward with left and right arrow keys. |
| FR2 | The system shall allow the player to accelerate when the the up arrow key is pressed and deccelerate when the down arrow is pressed  |
| FR2 | The system shall spawn multiple asteroids that move continuously across the screen. |
| FR3 | The system shall allow the player to shoot projectiles from the spaceship by pressing the spacebar. |
| FR4 | The system shall quit the game after pressing the escape key with out saving score. |
| FR5 | The system shall allow the Player to move the sprite to the boundary and have the sprite jump to the other side of the screen and continue moving uninterupted. |
| FR6 | The system shall remove all asteroids from a screen and respawn new ones after the correct answer is shot. |

### Math Problem Generation

| ID  | Requirement |
| :--: | ----------- |
| FR7 | The system shall generate a math problem involving the addition of three integers between 1 and 9. |
| FR8 | The system shall display the math problem prominently on the screen during gameplay at all times. |
| FR9 | The system shall assign answer values to asteroids currently on the screen. |
| FR10 | The system shall ensure exactly one asteroid contains the correct answer. |
| FR11 | The system shall randomize incorrect answer values for remaining asteroids between 3 and 27. |
| FR12 | The system shall generate a new equation when an asteroid is shot. |
| FR13 | The system shall not generate the same two equations in a row. |

### Scoring and Feedback

| ID  | Requirement |
| :--: | ----------- |
| FR14 | The system shall award one point when the player destroys the asteroid with the correct answer. |
| FR15 | The system shall alert the player for shooting an incorrect asteroid. |
| FR16 | The system shall remove a life on shooting the incorrect asteroid. |
| FR17 | The system shall end gameplay when all lives are lost. |
| FR18 | The system shall display the current score during gameplay. |
| FR19 | The system shall end the current round when a correct asteroid is destroyed. |
| FR20 | The system shall provide immediate visual feedback when an answer is correct or incorrect. |

### Leaderboard and Persistence

| ID  | Requirement |
| :--: | ----------- |
| FR23 | The system shall allow the player to enter their initials after a game ends. |
| FR24 | The system shall save player initials and corresponding scores. |
| FR25 | The system shall display a leaderboard sorted by highest score. |
| FR26 | The system shall limit initials entry to three characters. |
| FR27 | The system shall persist leaderboard data between game sessions. |

## Non-Functional Requirements

### Usability

| ID  | Requirement |
| :--: | ----------- |
| NFR1 | The game shall be playable using standard keyboard controls. |
| NFR2 | The user interface shall be clear and readable at standard screen resolutions. |
| NFR3 | The player shall be able to understand gameplay rules without external instructions. |
| NFR4 | On screen text shall use legible fonts and sufficient contrast. |
| NFR5 | The game shall provide intuitive feedback for player actions. |
| NFR6 | The game mechanics shall provide sufficient challenge while being completeable. |


### Reliability and Stability

| ID  | Requirement |
| :--: | ----------- |
| NFR7 | The game shall not crash during normal gameplay. |
| NFR8 | Invalid player input shall not cause unexpected behavior or termination. |
| NFR9 | The system shall handle repeated play sessions without degradation. |
| NFR10 | Leaderboard data shall not be corrupted by normal gameplay actions. |
| NFR11 | The game shall safely recover to the main menu after a game over event. |

### Maintainability and Portability

| ID  | Requirement |
| :--: | ----------- |
| NFR12 | The codebase shall follow consistent naming and formatting conventions. |
| NFR13 | Gameplay logic shall be modularized into separate components. |
| NFR14 | The system shall be executable on major operating systems. |
| NFR15 | New math problem types shall be addable with minimal code changes. |
| NFR16 | The leaderboard storage mechanism shall be easily replaceable or extendable. |


# Test Specification 
| :-------------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| TC1 | Verifies if player sprite rotates properly  | 1. Game is active and on gameplay screen. 2. Press Left arrow to rotate counterclockwise. 3. Press Right arrow key to rotate colockwise. | Left and Right Arrow Keys | The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | FR1, NFR1 |

| TC2 | Verifies player acclerates and deccelerates properly  | 1. Game is active and on gameplay screen. 2. Press up arrow to accelerat forard. 3. Press Down arrow key to deccelerate. | Up and Down Arrow Keys | The player will be propelled forward in the direction they are facing when the up arrow key is pressed and deccelerate slowly when the Down arrow key is pressed. | The player is propelled forward in the direction the are facing. When the input stops the player slowly comes to a stop. The player deccelerates slightly faster and comes to a full stop when the Down arrow is pressed. The motion is smooth with no jitter. | Pass | FR2, NFR1 |

| TC3 | Verifies player movement when passing screen boundaries  | 1. Game is active and on gameplay screen. 2. Press up arrow to accelerate forward. 3. Leave upper boundary of screen. 4. Appear on bootom of screen 5. Rotate to Right and bass right boundary. 6. Sprite appears on left side of screen | Up Arrow and Right Arrow Keys |  The player will accelerate forward and approach the top of the screen. When they cross the upper boundary, they will cross over to the bottom of the screen. When crossing the right boundary they cross onto the left side of the screen | The player accelerates to the top of of the screen and when crossing the top boundary, properly crosses and comes up from the bottom of the screen. When moving Right the player properly jumps to the left side of the screen after passing the right boundary. The motion is smooth with no jitter or delay in the player appearing on the opposite boundary. | Pass | FR1, FR2, FR5, NFR1 | 

| TC4 | Verifies player is able to shoot pellets. | 1. Game is active and on gameplay screen. 2. Player presses Spacebar  | Spacebar | The player will shoot a pellet when the space bar is pressed. | The player shoots a pellet when the space bar is pressed. | Pass | FR3, NFR1 |

## Integration tests
| ID | Description | Steps | Input Values | Expected Output | Actual Output | Pass/Fail | Requirement Link |
| TC5 | Verifies proper intergration of point system | 1. Game is active and on gameplay screen. 2. Play game to earn points. | Up, Down, Left, Right Arrowkeys and Spacebar | The game should successfully spawn 3 asteroids with one having the correct answer to a 3 interger addition problem. After the player shoots the asteroid the correct answer, the score will increase by one, all asteroids on the screen will be replaced with new asteroids and the math problem will also be replaced by a different problem. After shooting an incorrect answer, the player will lose a life and the problem and asteroids will remain the same until the player is out of lives or shoots the correct answer. | The game successfully spawns 3 asteroids with one having the correct answer to a 3 interger addition problem. After the player shoots the asteroid the correct answer, the score increases by one and all asteroids on the screen are replaced with new asteroids and the math problem is also replaced by a different problem. After shooting an incorrect answer, the player loses a life and the problem and asteroids remain the same until the player is out of lives or shoots the correct answer. | Pass | FR9, FR10, FR11, FR12, FR13, FR14, FR16, FR17, FR19, FR20 |

| TC6 | Verifies math problems function properly | 1. Game is active and on gameplay screen. 2. Player is able to view math problem on the screen. 3. After shooting the correct asteroid, the math problem changes to another differnt problem | Up, Down, Left, Right Arrowkeys and Spacebar | The player will be able to see the 3 integer addition problem and will be able to see a new problem and new corresponding asteroids after the problem is solved. |  The player is able to see the 3 integer addition problem and is be able to see a new problem and new corresponding asteroids after the problem is solved. | Pass | FR7, FR8, FR9, FR10, FR11, FR12, FR13 |
| TC7 | Verifies leaderboard functions properly | 1. Game is active and on gameplay screen. 2. Player earns points. 3. losing all lives the leaderboard pops up with an input to put in 3 letters | Up, Down, Left, Right Arrowkeys, all letter keys, and Spacebar | After the player runs out of lives the score, the player will see a leader board pop up that asks for 3 letters as an input. The player will be able to input those letters and be able to save their score. | After the player runs out of lives the score, the player is able to see a leader board pop up that asks for 3 letters as an input. The player is successfully able to input those letters and be save their score. | Pass | FR23, FR24, FR25, FR26 |


## System tests
| ID | Description | Steps | Input Values | Expected Output | Actual Output | Pass/Fail | Requirement Link |
| :-------------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| TC8 | Verifies elements successfully spawn on launch of game. | 1. Game is active and on gameplay screen. 2. Player should be able to see proper elements | Dragging game folder onto love 2D icon on desktop | The player will be able to see the game load with the the player sprite, three asteroids with answers on them, the name of the game with the current score, lives, and math problem below it, and see a space themed background. |  The player is able to see the game load with the the player sprite, three asteroids with answers on them that are floating around the screen and one asteroid has the correct answer, the name of the game with the current score, lives, and math problem below it, and see a space themed background. | Pass | FR2, FR7, FR 8, FR9, FR10, FR18 |
| TC9 | Verifies Leaderboard is saved between game sessions. | 1. Game is active and on gameplay screen. 2. Player plays through game once and runs out of lives. 3. Player writes 3 initials and presses enter to save score. 4. Player relaunches game and plays again. 5. After running out of lives again, the player will see that their previos score was saved | Dragging game folder onto love 2D icon on desktop, Up, Down, Left, Right Arrowkeys, all letter keys, and Spacebar, and the Enter Key | After running out of lives the player will be able to input 3 letters and press enter top save their score. After playing the game again, the player will be able to see their previous score on the leaderboard. |  After running out of lives the player is able to input 3 letters and press enter top save their score. After playing the game again, the player is able to see their previous score on the leaderboard. The top 10 scores are saved. | Pass | FR23, FR24, FR25, FR26, FR27 |


# Software Artifacts
<Describe the purpose of this section>
* [I am a link](to_some_file.pdf)
# Artifacts

[Use Case Diagrams](https://miro.com/app/board/uXjVJ67qWoE=/?share_link_id=553477000451)

[Class Diagram]()

[Sequence Diagram]()

[ClickUp Sprints](https://app.clickup.com/90132510734/v/s/901310732368)

[Gantt Chart](/gvsu-cis350-team1-1/docs/gantt_chart.pdf)
