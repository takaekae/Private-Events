class AddEventIdToInvites < ActiveRecord::Migration[7.0]
  def change
    add_reference :invites, :event, foreign_key: true
  end
end
