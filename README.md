# Project 4 - Memory Game

Submitted by: **Josed Vasquez**

**Memory Game** is a SwiftUI app where users flip cards to find matching pairs. The game includes multiple difficulty sizes, card-matching logic, reset functionality, scrolling for larger decks, and custom animations and styling.

Time spent: **6** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App loads to display a grid of cards initially placed face-down:
  - Upon launching the app, a grid of cards is visible.
  - Cards are facedown to indicate the start of the game.

- [x] Users can tap cards to toggle their display between the back and the face:
  - Tapping on a facedown card flips it to reveal the front.
  - Tapping a second card that is not identical flips both cards back down after a short delay.

- [x] When two matching cards are found, they both disappear from view:
  - The app checks whether two selected cards have matching symbols.
  - Matching cards disappear from the game board.
  - Non-matching cards return to the facedown position.

- [x] User can reset the game and start a new game via a button:
  - A Reset Game button restarts the game.
  - Resetting reshuffles the cards and clears the current game state.

## Optional Features

The following **optional** features are implemented:

- [x] User can select number of pairs to play with.
  - Users can choose between 3, 6, and 10 pairs.

- [x] App allows for user to scroll to see pairs out of view.
  - The card grid is wrapped in a ScrollView for larger games.

- [x] Added additional UI styling and animations.
  - Cards use custom colors and rounded corners.
  - Card flips and matched-card removal are animated.
  - A completion message is shown when the game is finished.

## Additional Features

The following **additional** features are implemented:

- [x] The app prevents users from selecting more than two cards while a match is being checked.
- [x] The app displays a "You Won!" message when all pairs have been matched.
- [x] A Play Again button lets the user quickly start another game after winning.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://youtube.com/shorts/E-OStRtk5_s?feature=share

## Notes

One challenge was implementing the card-matching logic while preventing the user from selecting additional cards during the comparison. I handled this by tracking the first selected card and temporarily disabling additional selections while two cards are being checked.

Another challenge was resetting the game correctly. The reset function recreates the card deck, shuffles the cards, and clears the selected-card state so the game starts fresh.

## License

Copyright 2026 Josed Vasquez

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
