class AddImageColumnToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_url, :text
  end
end
