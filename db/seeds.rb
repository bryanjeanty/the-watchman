require 'csv'
require_relative '../models'
require_relative '../avatar'

CSV.foreach(File.join(Dir.pwd,'/db/USR_DATA.csv'), headers: true) do |row|
    avatar = Avatar.new(row['first_name'], row['last_name'])
    avatar_url = avatar.get_avatar_url
    User.create(
        id: row['id'],
        username: row['username'],
        password: row['password'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        email: row['email'],
        birthday: row['birthday'],
        updated: Time.now,
        avatar_url: avatar_url
    )
end

CSV.foreach(File.join(Dir.pwd,'/db/POST_DATA.csv'), headers: true) do |row|
    Post.create(
    title: row['title'],
    content: row['content'],
    user_id: row['user_id'],
    updated: Time.now
    )
end