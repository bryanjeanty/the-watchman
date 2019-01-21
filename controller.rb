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
            password: params[:password],
            updated: Time.now,
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            birthday: params[:birthday]
        )
        session[:user_id] = user.id
        redirect '/dashboard'
    end
end

get '/dashboard' do
    @current_user = User.find(session[:user_id])
    @posts = Post.all
    erb(:dashboard)
end

post '/dashboard' do
    user = User.find(session[:user_id])

    post = Post.create(
        title: params[:title],
        content: params[:content],
        user_id: user.id,
        updated: Time.now
    )

    redirect '/dashboard'
end

get '/signout' do
    session[:user_id] = nil
    redirect '/'
end

get '/profile' do
    @current_user = User.find(session[:user_id])
    erb(:profile)
end

post '/profile' do
    user = User.find(session[:user_id])

    post = Post.create(
        title: params[:title],
        content: params[:content],
        user_id: user.id,
        updated: Time.now
    )

    redirect '/profile'
end

get '/profile/:user_id' do
    if params[:user_id].to_i == session[:user_id]
        redirect '/profile'
    else
        @other_user = User.find(params[:user_id])
        erb(:other_profile)
    end
end

get '/community' do
    @users = User.all
    erb(:community)
end

post '/deleteuser' do
    redirect '/'
end