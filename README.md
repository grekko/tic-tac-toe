# Tic Tac Toe

[![Build Status](https://travis-ci.org/grekko/tic-tac-toe.svg?branch=master)](https://travis-ci.org/grekko/tic-tac-toe)
[![Test Coverage](https://codeclimate.com/github/grekko/tic-tac-toe/badges/coverage.svg)](https://codeclimate.com/github/grekko/tic-tac-toe/coverage)

A naive or *creative* ruby implementation of an unbeatable tic-tac-toe program.
For a more scientific approach check out the article ["Tic Tac Toe: Understanding The Minimax Algorithm"](http://neverstopbuilding.com/minimax).


## Design goals

* The program should allow three game modes:
  * User vs. Computer
  * User vs. User
  * Computer vs. Computer
* The computer player should never lose
* The user can choose which player goes first


## Usage

You should have any latest ruby version installed. To be sure you can check the listed version in the provided [.travis.yml](/blob/master/.travis.yml).

```
git clone https://github.com/grekko/tic-tac-toe.git
cd tic-tac-toe
bundle install
./bin/tictactoe
```


## Development

Tests are written with [rspec](https://github.com/rspec/rspec) ([/spec](/tree/master/spec)-Directory). Run them all with:

```
rake
```

Generate code coverage report or have a look at [Codeclimate](https://codeclimate.com/github/grekko/tic-tac-toe/coverage)
```
open coverage/index.html
```

# IDEAS

- [ ] Reconsider coupling between CLI <-> Game/Match

