class AddAuthorNameToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :author_name, :string
  end
end
