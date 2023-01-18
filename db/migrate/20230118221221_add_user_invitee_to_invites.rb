class AddUserInviteeToInvites < ActiveRecord::Migration[7.0]
  def change
    add_reference :invites, :invitee, index: true
    add_foreign_key :invites, :users, column: :invitee_id
  end
end
