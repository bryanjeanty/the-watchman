require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './models'

enable :sessions


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
    if User.find_by(username: params[:username])
        flash[:error] = "User already exists! Try again"
        redirect '/signup'
    else
        user = User.create(
            username: params[:username],
            password: params[:password]
        )
        session[:user_id] = user.id
    end
    redirect '/dashboard'
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