class DropCalcPercentsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :calc_percents
  end
end
