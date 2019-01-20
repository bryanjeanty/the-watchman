require 'sinatra/activerecord'
require 'pg'

configure :development do
    set :database, {
        adapter: 'postgresql',
        host: 'localhost',
        database: ENV['WM_DATABASE'],
        username: ENV['WM_DATABASE_UN'],
        password: ENV['WM_DATABASE_PW']
    }
end

configure :production do
    set :database, ENV['DATABASE_URL']
end

class User < ActiveRecord::Base
end

class Post < ActiveRecord::Base
end