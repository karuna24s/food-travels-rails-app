class Destination < ApplicationRecord
  belongs_to :food
  belongs_to :user
  has_many :comments
  validates_presence_of :title, :content, :location
  validates :food_id, length: { minimum: 1 }, allow_nil: true
  validates :user_id, length: { minimum: 1 }, allow_nil: true
end
