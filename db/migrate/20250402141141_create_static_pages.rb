class CreateStaticPages < ActiveRecord::Migration[7.1]
  def change
    create_table :static_pages do |t|
      t.string :title, null: false
      t.boolean :requires_sign_in, null: false, default: false

      t.timestamps
    end
  end
end
