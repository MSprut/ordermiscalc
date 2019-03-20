class CreateCompetitors < ActiveRecord::Migration[5.2]
  def change
    create_table :competitors do |t|
      t.string :name, null: false, default: ''
      t.boolean :deleted, null: false, default: 0
      t.timestamps limit: 6, null: false
    end
  end
end
