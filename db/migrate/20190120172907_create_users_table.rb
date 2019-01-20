class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |type|
      type.string :username
      type.string :password
      type.datetime :updated
    end
  end
end
