require 'spec_helper'

# going by analogy with myrottenpotatoes/spec/controllers/movies_controller_spec.rb now...

describe MoviesController do

  describe 'find Similar Movies' do
  
    before :each do
      @random_director = "abc def"
      @fake_results = [mock('movie1'), mock('movie2')]
    end
  
    it 'should call the model method that performs director search' do
      Movie.should_receive(:find_by_director).with(@random_director)
      get :similar, {:director => @random_director}
    end
    
    describe 'after valid search' do
    
      before :each do
        Movie.stub(:find_by_director).and_return(@fake_results)
        get :similar, {:director => @random_director}
      end
    
      it 'should select the Similar Movies template for rendering' do
        response.should render_template('similar')
      end
      
      it 'should make the director search results available to that template' do
        assigns(:movies).should == @fake_results
      end
      
    end
    
    # Scenario 3
    describe 'after blank director search' do
      
      before :each do
        Movie.should_not_receive(:find_by_director)#.with("").and_return([])
      end
      
      it 'should call the model method with blank director' do     
        get :similar, {:director => "", :title => "random title"}
      end
      
      #it 'should have a nonzero movie title available' do
      #  params[:title].should be != nil
      #  params[:title].should be != ""
      #end
      
      it 'should render the main page' do
        get :similar, {:director => "", :title => "random title"}
        
        # http://stackoverflow.com/questions/648044/rspec-should-redirect-to-problem
        response.should redirect_to movies_path
      end
      
    end
  
  
  end  
end