require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './models'

get '/' do
    erb(:index)
end

get '/signin' do
    erb(:signin)
end

post '/signin' do
    redirect '/dashboard'
end

get '/signup' do
    erb(:signup)
end

post '/signup' do
    redirect '/signin'
end

get '/dashboard' do
    erb(:dashboard)
end

post '/dashboard' do
    redirect '/dashboard'
end

post '/signout' do
    redirect '/'
end

get '/profile' do
    erb(:profile)
end

post '/deleteuser' do
    redirect '/'
end