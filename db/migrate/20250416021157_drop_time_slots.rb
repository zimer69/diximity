class DropTimeSlots < ActiveRecord::Migration[8.0]
  def change
    drop_table :time_slots
  end
end
