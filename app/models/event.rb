class Event < ApplicationRecord
  # scope allows common queries to be defined herein and method names set
  scope :past_events, -> { where('date < ?', Time.zone.now) }
  scope :future_events, -> { where('date > ?', DateTime.now) }

  has_many :invites, dependent: :destroy
  has_many :attendings, foreign_key: :attended_event_id, dependent: :destroy
  has_many :attendees, through: :attendings, dependent: :destroy
  belongs_to :creator, class_name: "User"

  validates :name, :location, :date, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validates_presence_of :creator_id

end

