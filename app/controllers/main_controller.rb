# encoding: utf-8

class MainController < ApplicationController
  before_filter :check_authorize

  PER_PAGE = 10

  def index
    page_number = params[:page] || 1
    @emails = user_emails(page_number)
    respond_to do |format|
      format.json {render :layout => false}
    end
  end

  def new
    @email = Email.new
  end

  def create
    respond_to do |format|
      format.json do
        @email = Email.new params[:email]
        @email.user = current_user
        @email.email_attachments.build params[:email_attachments]
        unless @email.send_mail current_user.login, current_user.password
          @error_text = "Email not sent"
        end
        render :layout => false
      end
    end
  end

  def get_latest
    respond_to do |format|
      format.json do
        Email.get_latest current_user, params[:box_type]
        @emails = user_emails( 1 )
        render template: "main/index", layout: false
      end
    end
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

  private

  def user_emails( page_number )
    current_user.emails.page(page_number).per(PER_PAGE).
                        where(box_type: params[:box_type]).order('date_ desc')
  end

end
