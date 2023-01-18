class Attending < ApplicationRecord

  scope :confirmed, ->(event_id) { where(attended_event_id: event_id) }

  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'

  validates_presence_of :attendee_id, :attended_event_id
end
