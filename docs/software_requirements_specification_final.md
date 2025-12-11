SRS Markdown Structure (with test cases)
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
| FR3 | The system shall allow the player to shoot projectiles from the spaceship. |
| FR4 | The system shall detect collisions between projectiles and asteroids. |
| FR5 | The system shall remove an asteroid from the game when it is hit by a projectile. |

### Math Problem Generation

| ID  | Requirement |
| :--: | ----------- |
| FR6 | The system shall generate a math problem involving the addition of three integers. |
| FR7 | The system shall display the math problem prominently on the screen during gameplay. |
| FR8 | The system shall assign answer values to asteroids currently on the screen. |
| FR9 | The system shall ensure exactly one asteroid contains the correct answer. |
| FR10 | The system shall randomize incorrect answer values for remaining asteroids. |

### Scoring and Feedback

| ID  | Requirement |
| :--: | ----------- |
| FR11 | The system shall award points when the player destroys the asteroid with the correct answer. |
| FR12 | The system shall alert the player for shooting an incorrect asteroid. |
| FR13 | The system shall display the current score during gameplay. |
| FR14 | The system shall end the current round when a correct asteroid is destroyed. |
| FR15 | The system shall provide immediate visual feedback when an answer is correct or incorrect. |

### Leaderboard and Persistence

| ID  | Requirement |
| :--: | ----------- |
| FR16 | The system shall allow the player to enter their initials after a game ends. |
| FR17 | The system shall save player initials and corresponding scores. |
| FR18 | The system shall display a leaderboard sorted by highest score. |
| FR19 | The system shall limit initials entry to three characters. |
| FR20 | The system shall persist leaderboard data between game sessions. |

## Non-Functional Requirements

### Usability

| ID  | Requirement |
| :--: | ----------- |
| NFR1 | The game shall be playable using standard keyboard controls. |
| NFR2 | The user interface shall be clear and readable at standard screen resolutions. |
| NFR3 | The player shall be able to understand gameplay rules without external instructions. |
| NFR4 | On screen text shall use legible fonts and sufficient contrast. |
| NFR5 | The game shall provide intuitive feedback for player actions. |

### Reliability and Stability

| ID  | Requirement |
| :--: | ----------- |
| NFR6 | The game shall not crash during normal gameplay. |
| NFR7 | Invalid player input shall not cause unexpected behavior or termination. |
| NFR8 | The system shall handle repeated play sessions without degradation. |
| NFR9 | Leaderboard data shall not be corrupted by normal gameplay actions. |
| NFR10 | The game shall safely recover to the main menu after a game over event. |

### Maintainability and Portability

| ID  | Requirement |
| :--: | ----------- |
| NFR11 | The codebase shall follow consistent naming and formatting conventions. |
| NFR12 | Gameplay logic shall be modularized into separate components. |
| NFR13 | The system shall be executable on major operating systems. |
| NFR14 | New math problem types shall be addable with minimal code changes. |
| NFR15 | The leaderboard storage mechanism shall be easily replaceable or extendable. |

# Test Specification 
### Natasha will add her work here

# Artifacts

[Use Case Diagrams](https://miro.com/app/board/uXjVJ67qWoE=/?share_link_id=553477000451)

[Class Diagram]()

[Sequence Diagram]()

[ClickUp Sprints](https://app.clickup.com/90132510734/v/s/901310732368)

[Gantt Chart](/gvsu-cis350-team1-1/docs/gantt_chart.pdf)

