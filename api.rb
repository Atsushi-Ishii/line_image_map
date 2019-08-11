require 'sinatra'
require 'pry-byebug'
require './rich_menu'

# inrideo.serveo.net/webhook
post '/webhook' do
  RichMenu.new(request).reply
  head 200
end
