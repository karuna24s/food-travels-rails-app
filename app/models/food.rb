class Food < ApplicationRecord
  validates :name, presence: true
  has_many :destinations
  has_many :users, through: :destinations
end
