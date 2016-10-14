class Destination < ApplicationRecord
  belongs_to :food
  belongs_to :user
  has_many :comments
  validates_presence_of :title, :content, :location
end
