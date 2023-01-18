class User < ApplicationRecord
  scope :attending_event, ->(event_id) { self.attendings.where(attended_event_id: event_id).exists? }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :invites, foreign_key: :inviter_id, dependent: :destroy
  has_many :invites, foreign_key: :invitee_id, dependent: :destroy
  has_many :attendings, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :attendings, dependent: :destroy
  # associates user_id with creator_id in events table and allows event.creator method
  has_many :events, foreign_key: :creator_id, class_name: "Event", dependent: :destroy
end
