# encoding: utf-8

require 'spec_helper'

describe Email do
  before :all do
    @gmail = Gmail.connect("sdilshod.ex@gmail.com", "12345rewq")
    @user = FactoryGirl.create(:user)
  end

  it ".decode_of_mail" do
    @gmail.should be_logged_in
    @gmail.inbox.count.should > 3

    in_b = @gmail.inbox.find(:after => Date.new(2013,11,1)).last
    Email.decode_of_mail(in_b).should == "Привет"
#    Email.decode_of_mail(in_b).should =~ /What is the most effect/

#   Email.decode_of_mail(in_b, "body").should == "Все будить хорошо !!!"

    in_b = @gmail.inbox.find(:after => Date.new(2013,11,1)).first
    Email.decode_of_mail(in_b).should =~ /Gmail/
    Email.decode_of_mail(in_b, "body").should =~ /Hi Dilshod/
  end

  it ".get_latest" do
    Email.get_latest @user
#   Email.count.should > 0
  end

end
