class Invite < ApplicationRecord

  scope :received, ->(event_id, user_id) { where(event_id: event_id, invitee_id: user_id) }

  belongs_to :event
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  validates_presence_of :event_id, :inviter_id, :invitee_id

end
