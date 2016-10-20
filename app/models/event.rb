class Event < ApplicationRecord
  belongs_to :state
  belongs_to :user
  has_many :rsvps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :attendees, through: :rsvps, source: :user
  validates :name, :date, :city, :state, presence: true
  validate :event_is_in_the_future

  def event_is_in_the_future
  	if date <= Date.today
  		errors.add(:date, "must be in the future")
  	end
  end
end
