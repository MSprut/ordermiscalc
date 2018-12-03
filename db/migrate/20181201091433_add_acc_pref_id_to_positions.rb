class AddAccPrefIdToPositions < ActiveRecord::Migration[5.2]
  def change
    add_reference :position_salaries, :accountant_preference, foreign_key: true
  end
end
