class CreateProducts < ActiveRecord::Migration[7.0]
  def up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end

  def down
    drop_table :products
  end
end
