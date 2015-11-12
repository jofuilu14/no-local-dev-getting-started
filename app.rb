# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'spec_helper'
class UsersController < ApplicationController

  def form
    @titre = "Inscription"
  end
end
describe UsersController do
  render_views
  describe "GET 'form'" do

    it "devrait réussir" do
      get :form
  
    end

    it "devrait avoir le bon titre" do
      get :form
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
