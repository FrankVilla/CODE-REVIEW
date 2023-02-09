Feature: list of Movies

Background:
    The user Open list of Movies

@ios
Scenario: Open list of Movies
    Given I Open list of Movies
    Then The list of popular movies is open
    When Select Upcoming movies
    When Select the Top rates movies
    And  The list of popular movies is displayed

@ios
Scenario: Select a movie
    Given I Open list of Movies 
    When I selected a movie
    Then The detail page is displayed
    Then I close detail page
    And The list of popular movies is displayed

@ios
Scenario:select the movie as watched and no watched
    Given I Open list of Movies
    When I selected a movie as watched
    When I selected a movie as no watched
    And The list of popular movies is displayed

