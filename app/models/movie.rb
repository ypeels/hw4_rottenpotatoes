class Movie < ActiveRecord::Base
  def Movie.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def Movie.find_by_director(director)
    # syntax from Homework 2...
    # how was I supposed to write a test when i didn't know the syntax??
    # debugger # this was my only resort...and from rails server - doesn't work from rspec??
    Movie.find :all, :conditions => {:director => director}
  end
  
end
