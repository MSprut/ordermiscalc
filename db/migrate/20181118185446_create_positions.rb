class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :name, null: false, default: '', limit: 127
      t.boolean :deleted, null: false, default: 0
      t.timestamps limit: 6, null: false
    end
  end
end
