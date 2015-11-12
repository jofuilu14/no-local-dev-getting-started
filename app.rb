# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'
include ActiveModel::Validations
include ActiveModel::Conversion
extend  ActiveModel::Naming

class Contact < ActiveRecord::Base
 
  attr_accessor :firstname, :lastname, :email, :message
 
  validates :lastname, :firstname, :email, :message, presence: true
  validates :email, :format => { :with => %r{.+@.+\..+} }, allow_blank: true
 
end
def persisted?
  false
end
 
def initialize(attributes = {})
  attributes.each do |name, value|
    send("#{name}=", value)
  end
  
  class ContactsController < ApplicationController
 
  def form
    @contact = Contact.form
  end
 
  def create
    @contact = Contact.form params[:contact]
 
    if @contact.valid?
     
      redirect_to new_contact_path, flash: {success: t(:"create.message_has_been_sent")}
    else
      render :form
    end
  end
 
end
class Lead < ActiveRecord::Base
  self.table_name = 'salesforce.lead'
end

get "/" do
  @leads = Lead.all
  erb :index
end

get "/home" do
  erb :home
end


class Contact < ActiveRecord::Base
  self.table_name = 'salesforce.contact'
end

#get "/contacts" do
#  @contacts = Contact.all
#  erb :index
#end

get "/create" do
  dashboard_url = 'https://dashboard.heroku.com/'
  match = /(.*?)\.herokuapp\.com/.match(request.host)
  dashboard_url << "apps/#{match[1]}/resources" if match && match[1]
  redirect to(dashboard_url)
end
