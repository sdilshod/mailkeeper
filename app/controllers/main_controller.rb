class MainController < ApplicationController

	def index
		@emails = Email.order('date_ desc')
	end
	
	def get_latest
	  Email.get_latest params[:lgn], Base64.decode64(params[:pwd])
	  redirect_to :action => 'index'
	end

end
