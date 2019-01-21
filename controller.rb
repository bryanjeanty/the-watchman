require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './models'
require './avatar'

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
        avatar = Avatar.new(params[:first_name], params[:last_name])
        avatar_url = avatar.get_avatar_url
        user = User.create(
            username: params[:username],
            password: params[:password],
            updated: Time.now,
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            birthday: params[:birthday],
            avatar_url: avatar_url
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

post '/deletepost' do
    current_post = Post.find(params[:post_id])
    current_post.destroy

    redirect '/profile'
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

get '/settings' do
    @current_user = User.find(session[:user_id])
    erb(:settings)
end

post '/settings' do
    user = User.find(session[:user_id])
    new_username = params[:username]
    new_password = params[:password]
    avatar = Avatar.new(params[:first_name], params[:last_name])
    avatar_url = avatar.get_avatar_url

    if (new_username.length != 0) && (new_password.length != 0)
        user.update(
            username: new_username,
            password: new_password,
            updated: Time.now,
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            birthday: params[:birthday],
            avatar_url: avatar_url
        )
    else
        user.update(
            updated: Time.now,
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],
            birthday: params[:birthday],
            avatar_url: avatar_url
        )
    end
    
    redirect '/profile'
end

get '/community' do
    @users = User.all
    erb(:community)
end

post '/deleteuser' do
    delete_user = User.find(params[:user_id])
    delete_user.destroy
    session[:user_id] = nil

    redirect '/'
end