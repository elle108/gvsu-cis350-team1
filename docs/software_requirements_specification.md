# Math-eroids: Software Requirements Specification

## Overview

This document provides a comprehensive Software Requirements Specification (SRS) for the Math-eroids educational game. It outlines both functional and non-functional requirements that define the system's expected behavior, performance characteristics, and constraints. This specification serves as a foundational document for development, testing, and validation of the Math-eroids game system.

## Functional Requirements

### 1. User Account & Progress
1. The system shall allow users to log in.
2. The system shall save the game score to that specific user's profile.
3. The system shall show the leaderboard with top scores and their respective usernames.

### 2. Gameplay Mechanics
1. The system shall allow the user to move their character in 4 directions.
2. The system shall allow the user to pause and resume the game.
3. The system shall display how many lives the user has left.
4. The system shall display a level completion message when the level is successfully completed.

### 3. Math Game Logic
1. The system shall display the current math problem at the top of the screen.
2. The system shall display asteroids with answers to the math problem on them that move across the screen.
3. The system shall remove answer asteroids with the correct answer when they are hit.
4. The system shall display an error message if the user shoots an incorrect answer.

### 4. Game Progression
1. The system shall increase asteroid speed as levels progress.
2. The system shall increase the number of asteroids on the screen as levels progress.
3. The system shall display the user's score on the screen.
4. The system shall track and display the time elapsed for each level.

## Non-Functional Requirements

### 1. Accessibility & UI Design
1. The system shall have different font options that include a dyslexic-friendly font option.
2. The system shall provide both dark mode and light mode display options.
3. The system shall use a colorblind-friendly color schema.
4. The system shall ensure all controls are clearly labeled with their functionality.
5. The system shall use consistent designs across all pages and game levels.

### 2. Performance & Compatibility
1. The system shall support at least 50 concurrent users without performance degradation.
2. The system shall load the game and game assets in under 5 seconds.
3. The system shall maintain responsive gameplay without noticeable lag, even when there are many asteroids on the screen.
4. The system shall be able to run the game successfully across all browsers (e.g., Chrome, Firefox, Safari, etc).

### 3. Security & Data Integrity
1. The system shall require user passwords to be at least eight characters long.
2. The system shall require users' usernames to be unique.
3. The system shall be protected with appropriate website security protections.
4. The system shall require that usernames and passwords be monitored for inappropriate entries.
5. The system shall transmit user data securely over HTTPS.
6. The system shall log users out after 15 minutes of inactivity for security.

---

This SRS document will be updated throughout the project lifecycle as requirements evolve and new features are identified.