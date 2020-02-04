# Project #1 - Game of Set (OnTrack)
The goal of this project is to recreate the card game Set as a text-based application using Ruby.

## Table of Contents
* [Technologies Used](#technologies-used)
* [Required Functionality Included](#required-functionality)
* [Additional Functionality Included](#additional-functionality)
*  [Installation Guide](#installation-guide)
* [Usage Guide](#usage-guide)
* [Testing](#testing)
* [Styling](#styling)

## Technologies Used
Ruby v2.6.3
Ruby Gems:
- tty-table
- tty-prompt
- paint

## Required Functionality Included
- Deal the appropriate number of cards
- Verify the correctness of player-identified sets
- Replace the identified cards with new ones
- Keep track of score to identify a winner

## Additional Functionality Included
- Option for ASCII visual style versus table display
- Menus
- Tutorial
- Hints
- High score tracking across multiple games
- Added a computer player fucntionality


## Installation Guide
0. Requires Ruby v2.6.3 or later.
1. Download the zip archive of the OnTrack repository.
2. Navigate to the 'Project 1 OnTrack' directory.
3. Install the required Ruby gems with the following command:
```
$ bundle install
```

## Usage Guide
If you are unfamiliar with the card game Set, please follow the link below to be briefed on the rules or use the tutorial provided in-game.
- http://magliery.com/Set/SetRules.html

From the 'Project 1 OnTrack' directory, run the following command to start the program:
```
$ ruby lib/game.rb
```

To navigate the menu, use the up and down arrow keys to highlight the desired menu option. Then press Enter to select the option.

To select cards during gameplay, use the up and down arrow keys to highlight a card in the potential set. Press space to select the card, then press enter once all desired cards have been selected.

The default mode for displaying the cards during gameplay is ASCII graphics mode. This can be changed to table mode in Settings from the main menu.

If shapes overlap in graphics mode, widen the terminal window.

## Testing
Unit testing has been done on verification of Set correctness (Table.isSet function), as well as score adjustments (PlayerGroup.updateScore function), using Test::Unit.
From the test directory, the following commands can be used to run said tests.
```
$ ruby table_test.rb
```
```
$ ruby playerGroup_test.rb
```

The program's overall functionality has been user-tested thoroughly.

## Styling
All Ruby files in this project adhere to the rules in the style guide found [here](https://github.com/airbnb/ruby).

## Authors
- Jing George
- Jack Hanley
- Jack Thompson
- Snigdha Tiwari
- Von Mbah
