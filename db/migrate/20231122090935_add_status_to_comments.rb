class AddStatusToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :status, :string
    add_column :comments, :default, :string
    add_column :comments, :public, :string
  end
end
