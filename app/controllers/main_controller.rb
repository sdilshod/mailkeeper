# encoding: utf-8

class MainController < ApplicationController
  before_filter :check_authorize

  def index
    b_type = params[:e_type] || "inner"
    @emails = current_user.emails.where(:box_type => b_type ).paginate(:page => params[:page]).order('date_ desc')
  end

  def new
  @email = Email.new
  end

  def create
    @email = Email.new params[:email]
    @email.user_id=current_user.id
    @email.email_attachments.build params[:email_attachments]
    if @email.save
      unless @email.send_mail current_user.login, current_user.password
        flash[:error]="Не удалось отправить почту"
      end
      redirect_to :action => 'index'
    else
      flash[:error]="Ошибка в сохранение почты"
      render :action => 'new'
    end
  end

  def get_latest
    Email.get_latest current_user, params[:e_type]
    redirect_to :action => 'index'
  end

  def show
    @email = Email.find params[:id]
    @email.mark_as_read!
  end

  def download
  e_attach = EmailAttachment.find(params[:id])
    if e_attach
      send_file e_attach.attached_file.path,
              :filename => e_attach.attached_file_file_name,
              :type => e_attach.attached_file_content_type
    end
  end

  def view_js
    respond_to do |f|
      f.json {render :action=>"view_js"}
      f.html {render :text=> "dddljkdlkjd"}
    end
  end

  def destroy
    id = params[:id]
    current_user.emails.clear_all_inner(current_user) if id == "all"
 	  redirect_to :action => 'index'
  end

end
