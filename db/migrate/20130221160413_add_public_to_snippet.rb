class AddPublicToSnippet < ActiveRecord::Migration
  def change
    add_column :snippets, :public, :boolean
  end
end
