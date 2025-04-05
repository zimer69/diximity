class DropHospitalsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :hospitals
  end
end
