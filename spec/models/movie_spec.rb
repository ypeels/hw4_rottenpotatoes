require 'spec_helper'

describe Movie do

  before :each do
    @@random_director = "ghi jkl"
  end

  describe 'search by director' do
    
    it 'should invoke Movie.find with the correct arguments' do
    
      # i didn't KNOW (recall) what the right syntax was for Movie.find until i fiddled with it...
      Movie.should_receive(:find).once.with(:all, :conditions => {:director => @@random_director})
      Movie.find_by_director(@@random_director)
    end

    # not sure how to write this test, not sure i care anymore
    #it 'should return an array of movies, or nil' # hmmmm should i just let it search the db??
    
  end
  
end
