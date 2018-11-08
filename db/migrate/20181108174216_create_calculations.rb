class CreateCalculations < ActiveRecord::Migration[5.2]
  def change
    create_table :calculations do |t|

      t.timestamps
    end
  end
end
