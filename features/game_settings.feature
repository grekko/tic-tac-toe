Feature: Game settings
  Scenario: Playing Human vs. Human
    When I cd to "../.."
    When I run `ruby tictactoe.rb`
    Then the output should contain:
    """
    Welcome!
    """
    Then the features should all pass

