class Destination < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :location, presence: true
  has_many :comments
  belongs_to :food
  belongs_to :user
end
