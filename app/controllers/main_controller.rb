class MainController < ApplicationController

	def index
	  b_type = params[:e_type] || "inner"
		@emails = Email.where(:box_type => b_type ).order('date_ desc')
	end
	
	def get_latest
	  Email.get_latest params[:lgn], Base64.decode64(params[:pwd]), params[:e_type]
	  redirect_to :action => 'index'
	end
	
	def show_mails
	
	end

end
