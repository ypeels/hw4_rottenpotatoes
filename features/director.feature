# Homework 4 Part 3
# http://pastebin.com/L6FYWyV7

Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and serach on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

  
# Requirements
# (1) modify existing views
# (2) create new step definition
# (3) possibly add a line or two to features/support/paths.rb
Scenario: add director to existing movie

  # features/support/paths.rb
  When I go to the edit page for "Alien"
  
  # app/views/movies/edit.html.haml
  And  I fill in "Director" with "Ridley Scott"
  
  # no new code - passes immediately
  And  I press "Update Movie Info"
  
  # app/views/movies.show.html.haml + features/step_definitions/movie_steps.rb 
  Then the director of "Alien" should be "Ridley Scott"
  
  

# Requirements
# modify existing "Show Movie" view
# add a route, view, and controller method
Scenario: find movie with same director

  # passes immediately (with my extra features/support/paths.rb code from Scenario 1)
  Given I am on the details page for "Star Wars"
  
  # app/views/movies.show.html.haml + config/routes.rb?
  When  I follow "Find Movies With Same Director"
  
  # features/support/paths.rb (not QUITE duplicated information - you have to confirm the mapping!)
  Then  I should be on the Similar Movies page for "Star Wars"
  
  # TDD for new functionality: spec/controllers/movies_controller_spec.rb + spec/models/movie_spec.rb
  # also need to update app/views/movies/similar.html.haml
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"
  
 
  

# Sad path
Scenario: can't find similar movies if we don't know director (sad path)

  # should pass out of box
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  
  # app/controllers/movies_controller.rb + spec
  # also had to modify show.html.haml to pass title
  And  I should be on the home page
  And   I should see "'Alien' has no director info"