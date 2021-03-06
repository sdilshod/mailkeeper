# encoding: utf-8

require 'spec_helper'

describe MainController do

  before :all do
    @user = User.create(:login => "sdilshod.ex@gmail.com", :password => "12345rewq")
  end

  it "User must authorized for getting this" do
    get 'index'
    response.should redirect_to(root_url)
end

  it "should create email for sending to" do
    session[:current_user_id]=@user.id

    post 'create', {:email=>{:email_address=>"blalba@gmail.com", :subject => "letter", :message => "message of the letter"}, :email_attachments => {:email_attachments=>{:attached_file=>"#{Rails.root}/Readme.md"}}}
    response.should redirect_to(emails_url)

  end

end
