# encoding: utf-8

require 'spec_helper'

describe MainController do

	it "User must authorized for getting this" do
		get 'index'
		response.should redirect_to(root_url)
	end
	
end



