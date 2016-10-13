class Destination < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :location, presence: true
end
