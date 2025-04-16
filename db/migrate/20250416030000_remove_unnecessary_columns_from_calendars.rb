class RemoveUnnecessaryColumnsFromCalendars < ActiveRecord::Migration[7.0]
  def change
    remove_column :calendars, :date, :date
    remove_column :calendars, :start_time, :time
    remove_column :calendars, :end_time, :time
    remove_column :calendars, :status, :string
    remove_column :calendars, :patient_name, :string
    remove_column :calendars, :patient_email, :string
  end
end 