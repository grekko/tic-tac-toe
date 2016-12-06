# Tic Tac Toe

[![Build Status](https://travis-ci.org/grekko/tic-tac-toe.svg?branch=master)](https://travis-ci.org/grekko/tic-tac-toe)
[![Test Coverage](https://codeclimate.com/github/grekko/tic-tac-toe/badges/coverage.svg)](https://codeclimate.com/github/grekko/tic-tac-toe/coverage)

Ruby implementation of an unbeatable tic-tac-toe program for my 8th light application.


## Feature requirements

* The program allows three game modes:
  * User vs. Computer
  * User vs. User
  * Computer vs. Computer
* The computer should never lose
* The user can choose which player goes first


## CLI Version

The CLI version requires at least ruby version 2.3. Run the program with

```
ruby tictactoe.rb
```


## Development

Unit tests are written with rspec (see: [specs](/specs)) and acceptance tests are written
with aruba (see: [features](/features)).

Run all tests with:

```
rake
```

Code coverage:
```
open coverage/index.html
```
