class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |type|
      type.string :title
      type.text :content
      type.references :users
      type.datetime :updated
    end
  end
end