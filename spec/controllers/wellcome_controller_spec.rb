# encoding: utf-8

require 'spec_helper'

describe WellcomeController do

	it "should create user and autorize them" do
		post :index, {:user => {:login => "sdilshod.ex@gmail.com", :password => "12345rewq"}, :registration => "1"}
		response.should redirect_to emails_url
		User.count.should > 0
		
		post :index, {:user => {:login => "sdilshod.ex@gmail.com", :password => "12345rewq"}}
		response.should redirect_to emails_url		
		
	end
	
end
