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
    user = User.find_by(username: params[:username])
    if (user) && (user.password == params[:password])
        session[:user_id] = user.id
        redirect '/dashboard'
    else
        flash[:si_error] = "Something went wrong! Try again"
        redirect '/signin'
    end
end

get '/signup' do
    erb(:signup)
end

post '/signup' do
    if User.find_by(username: params[:username])
        flash[:su_error] = "User already exists! Try again"
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
    session[:user_id] = nil
    redirect '/'
end

get '/profile' do
    erb(:profile)
end

post '/deleteuser' do
    redirect '/'
end