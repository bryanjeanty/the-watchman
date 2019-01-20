require_relative '../controller'
require 'csv'

# CSV.foreach('./USR_DATA.csv', headers: true) do |row|
#     User.create(
#         username: row['username'],
#         password: row['password']
#     )
# end

User.create(
    username: 'bryanjay',
    password: 'jay_bryan01'
)