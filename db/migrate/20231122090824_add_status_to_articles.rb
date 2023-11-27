class AddStatusToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :status, :string
    add_column :articles, :default, :string
    add_column :articles, :public, :string
  end
end
