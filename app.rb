# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

class Stream
  def each
    100.times { |i| yield "#{i}\n" }
  end
end

get('/stream') { Stream.new }

class Lead < ActiveRecord::Base
  self.table_name = 'salesforce.lead'
end


get "/" do
  @leads = Lead.all
  erb :index
end

def new
  @lead = Lead.new
end
def create
  lead = Lead.new(params[:lead])
  lead.IsRecurrence = false
  lead.IsReminderSet = false
  lead.Priority = "Normal"
  user = User.first
  lead.OwnerId = user.Id
  if (lead.save)
    redirect_to(lead, :notice => 'Lead was successfully created.')
  end
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
