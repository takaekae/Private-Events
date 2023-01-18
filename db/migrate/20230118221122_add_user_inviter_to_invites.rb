class AddUserInviterToInvites < ActiveRecord::Migration[7.0]
  def change
    add_reference :invites, :inviter, index: true
    add_foreign_key :invites, :users, column: :inviter_id
  end
end
