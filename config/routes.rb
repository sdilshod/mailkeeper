Mailkeeper::Application.routes.draw do

  root :to => 'wellcome#index'

  match 'emails/:e_type/get_latest' => 'main#get_latest', :as => :get_emails
  match 'emails' => 'main#index', :as => :emails
  match 'emails/:id/show' => 'main#show', :as => :email_show
  match 'emails/new' => 'main#new', :as => :email_new
  match 'emails/create' => 'main#create', :as => :email_create
  match 'email/:id/destroy' => 'main#destroy', :as => :destroy_email

  match 'email_attachment/:id/download' => 'main#download', :as => :download

  match 'session' => 'wellcome#destroy_session', :as => :destroy_session

end
