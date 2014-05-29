require 'spec_helper'

describe StreamsController do
	describe "GET #index" do
	    it "responds successfully with an HTTP 200 status code" do
	     	get :index
	     	expect(response).to be_success
	     	expect(response.status).to eq(200)
	  	end

	  	it "renders the index template" do
	      get :index
	      expect(response).to render_template("index")
	    end

	    it "@stream_list has streams to show" do
	    	get :index
	    	assigns(:stream_list).should_not be_empty
	    end

	    it '@stream_list has 16 streams to show for the first page' do
	    	get :index
	    	assigns(:stream_list).length.should eq(16)
	    end

	    it 'user logs in with a popular game preference, and 20 streams still show' do
	    	test = User.create(email: "test@abc.com", password: "abc", number_of_streams_per_page: 20, number_of_stream_pages: 1)
	    	game1 = Game.create name:"League of Legends"
	    	game2 = Game.create name:"Dota 2"
	    	test.games << [game1, game2]
	    	sign_in :user, test
	    	get :index
	    	assigns(:stream_list).length.should eq(20)
	    end
    end
end
	