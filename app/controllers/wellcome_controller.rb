# encoding: utf-8

class WellcomeController < ApplicationController
	

	def index
		if request.post?
		  if params.include?(:registration)
		  	@user = User.new params[:user]
		  	if @user.save
		  	  session[:current_user_id] = @user[:id]
		  	  redirect_to emails_url
		  	else
		  	  flash[:notice] = "Ошибка в регистрации"
		  	end
		  else
		  	@user = User.find_by_login params[:user][:login]
		  	if @user
		  	  if params[:user][:password] == @user.password
					  session[:current_user_id] = @user[:id]
					  redirect_to emails_url
		  	  else
			  	  flash[:notice] = "Не верный пароль пользователя"
		  	  end
		  	else
		  	  flash[:notice] = "Пользователь не найдено в БД"
		  	end
		  end
		end
	end
	
	def destroy_session
		session[:current_user_id]=nil
		redirect_to root_url
	end


end