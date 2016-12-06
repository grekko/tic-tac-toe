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


## Usage

You should have ruby 2.3.1 installed.

```
bundle install
ruby tictactoe.rb
```


## Development

Unit tests are written with [rspec](https://github.com/rspec/rspec) ([/spec](/tree/master/spec)-Directory) and acceptance tests are written
with [aruba](https://github.com/cucumber/aruba) ([/features](/tree/master/features)).

Run all tests with:

```
rake
```

Generate code coverage report or have a look at [Codeclimate](https://codeclimate.com/github/grekko/tic-tac-toe/coverage)
```
open coverage/index.html
```
