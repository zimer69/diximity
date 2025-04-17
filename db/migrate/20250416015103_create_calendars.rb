class CreateCalendars < ActiveRecord::Migration[8.0]
  def change
    create_table :calendars do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :status
      t.string :patient_name
      t.string :patient_email

      t.timestamps
    end
  end
end
