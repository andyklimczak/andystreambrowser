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

	    it 'user logs in with a popular game preference, and 16 streams still show' do
	    	test = User.create(email: "test@abc.com", password: "abc", games:["League of Legends"])
	    	sign_in :user, test
	    	get :index
	    	assigns(:stream_list).length.should eq(16)
	    end
    end
end
	