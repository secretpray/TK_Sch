#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School!</a>"
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do
  @user_name = params[:user_name]
  @phone	   = params[:phone]
  @user_date = params[:user_date]
  @user_time = params[:user_time]
  @list      = params[:list]
  f = File.open './public/user.txt', 'a'
  f.write "User: #{@user_name}, Phone: #{@phone}, Date and time: #{@user_date} at #{user_time} to @{@list}"
  f.close
  erb :visit
end