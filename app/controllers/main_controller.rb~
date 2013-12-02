class MainController < ApplicationController
	before_filter :check_authorize


	def index
	  b_type = params[:e_type] || "inner"
		@emails = Email.where(:box_type => b_type ).order('date_ desc')
	end
	
	def get_latest
	  Email.get_latest current_user.login, current_user.password, params[:e_type]
	  redirect_to :action => 'index'
	end
	
	def show
		@email = Email.find params[:id]
	end

end
