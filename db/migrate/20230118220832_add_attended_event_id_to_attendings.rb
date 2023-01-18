class AddAttendedEventIdToAttendings < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendings, :attended_event, index: true
    add_foreign_key :attendings, :events, column: :attended_event_id
  end
end
