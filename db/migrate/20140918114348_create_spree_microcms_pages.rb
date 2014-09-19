class CreateSpreeMicrocmsPages < ActiveRecord::Migration
  def change
    create_table :spree_microcms_pages do |t|
      t.text :content, default: ''
      t.string :key, null: true, default: ''
      t.string :presentation, null: false, default: ''
      t.string :ancestry
      t.integer :order
      t.timestamps

      t.index :key
      t.index :ancestry
      t.index :order
    end
  end
end
