class AddHasAIContentColsToStaticPages < ActiveRecord::Migration[8.0]
  def change
    add_column :static_pages, :prompt_id, :integer
    add_column :static_pages, :prompt_additions, :text
    add_column :static_pages, :generate_content_on_create, :boolean, default: false
  end
end
