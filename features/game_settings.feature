Feature: Game settings
  Scenario: Playing Human vs. Human
    When I cd to "../.."
    When I run `ruby tictactoe.rb` interactively
    Then I type "Arnold"
    Then I type "N"
    Then stdout should contain "Hi, whats your name?"
    And stdout should contain "Hi Arnold!"
    And stdout should contain "Like to play tic tac toe?"
    And the features should all pass

