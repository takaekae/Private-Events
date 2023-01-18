class AddAttendeeIdToAttendings < ActiveRecord::Migration[7.0]
  def change
    add_reference :attendings, :attendee, index: true
    add_foreign_key :attendings, :users, column: :attendee_id
  end
end
