class CreateAiPrompts < ActiveRecord::Migration[8.0]
  def change
    create_table :ai_prompts do |t|
      t.string :title
      t.text :response_format
      t.text :content
      t.json :additional_options, default: {}
      t.timestamps
    end
  end
end
