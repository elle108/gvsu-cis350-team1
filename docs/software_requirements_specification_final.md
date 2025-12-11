# Overview

This Software Requirements Specification (SRS) document defines the functional and non-functional requirements for Math-eroids, a math based educational game inspired by the classic Asteroids. The purpose of this document is to clearly describe what the software does, how it behaves, and the constraints under which it operates. This SRS reflects the final implemented version of the project and serves as a reference for development, testing, and evaluation.

# Software Requirements

This section outlines the required behavior and quality attributes of Math-eroids. Functional Requirements describe what the system must do, while Non-Functional Requirements describe how well the system must perform these functions.

## Functional Requirements

### Gameplay Mechanics

| ID  | Requirement |
| :--: | ----------- |
| FR1 | The system shall display a player controlled spaceship that can move in all directions on the screen. |
| FR2 | The system shall spawn multiple asteroids that move continuously across the screen. |
| FR3 | The system shall allow the player to shoot projectiles from the spaceship by pressing the spacebar. |
| FR4 | The system shall detect collisions between projectiles and asteroids. |
| FR5 | The system shall remove an asteroid from the game when it is hit by a projectile. |
| FR6 | The system shall pause gameplay on pressing the escape key. |
| FR7 | The system shall resume gameplay on pressing the escape key. |
| FR8 | The system shall remove an asteroid from the game when it is hit by a projectile. |

### Math Problem Generation

| ID  | Requirement |
| :--: | ----------- |
| FR9 | The system shall generate a math problem involving the addition of three integers between 1 and 9. |
| FR10 | The system shall display the math problem prominently on the screen during gameplay at all times. |
| FR11 | The system shall assign answer values to asteroids currently on the screen. |
| FR12 | The system shall ensure exactly one asteroid contains the correct answer. |
| FR13 | The system shall randomize incorrect answer values for remaining asteroids between 3 and 27. |
| FR14 | The system shall generate a new equation when an asteroid is shot. |
| FR15 | The system shall not generate the same two equations in a row. |

### Scoring and Feedback

| ID  | Requirement |
| :--: | ----------- |
| FR16 | The system shall award one point when the player destroys the asteroid with the correct answer. |
| FR17 | The system shall alert the player for shooting an incorrect asteroid. |
| FR18 | The system shall remove a life on shooting the incorrect asteroid. |
| FR19 | The system shall end gameplay when all lives are lost. |
| FR20 | The system shall display the current score during gameplay. |
| FR21 | The system shall end the current round when a correct asteroid is destroyed. |
| FR22 | The system shall provide immediate visual feedback when an answer is correct or incorrect. |

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
| NFR56 | The game mechanics shall provide sufficient challenge while being completeable. |


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
| TC1 | Verifies if player sprite rotates properly  | 1. Game is active and on gameplay screen. 2. Press Left arrow to rotate counterclockwise. 3. Press Right arrow key to rotate colockwise. | Left and Right Arrow Keys | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC2 | Verifies player acclerates and deccelerates properly  | 1. Game is active and on gameplay screen. 2. Press up arrow to accelerat forard. 3. Press Down arrow key to deccelerate. | Up and Down Arrow Keys | Expected Output: The player will be propelled forward in the direction they are facing when the up arrow key is pressed and deccelerate slowly when the Down arrow key is pressed. | Actual Output: The player is propelled forward in the direction the are facing. When the input stops the player slowly comes to a stop. The player deccelerates slightly faster and comes to a full stop when the Down arrow is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC3 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC4 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |


## Integration tests
| ID | Description | Steps | Input Values | Expected Output | Actual Output | Pass/Fail | Requirement Link |
| TC5 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC6 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC7 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |

## System tests
| ID | Description | Steps | Input Values | Expected Output | Actual Output | Pass/Fail | Requirement Link |
| :-------------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| TC8 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC9 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |
| TC10 | Verifies if player sprite rotates properly  | 1. While game  | Use left arrowkey to rotate left and right arrowkey to rotate to the right | Expected Output: The player will rotate counterclockwise when the left arrow key is pressed and rotate clockwise when the right arrow key is pressed. | Actual Output: The player rotates counterclockwise when the left arrow key is pressed and rotates clockwise when the right arrow key is pressed. The motion is smooth with no jitter. | Pass | Requirement Link |


# Software Artifacts
<Describe the purpose of this section>
* [I am a link](to_some_file.pdf)
# Artifacts

[Use Case Diagrams](https://miro.com/app/board/uXjVJ67qWoE=/?share_link_id=553477000451)

[Class Diagram]()

[Sequence Diagram]()

[ClickUp Sprints](https://app.clickup.com/90132510734/v/s/901310732368)

[Gantt Chart](/gvsu-cis350-team1-1/docs/gantt_chart.pdf)
