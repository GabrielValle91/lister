class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.string :name
      t.string :item_type
      t.integer :qty, default: 1
      t.boolean :completed
      t.integer :list_id

      t.timestamps
    end
    add_index :list_items, :list_id
  end
end
