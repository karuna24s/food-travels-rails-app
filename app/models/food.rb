class Food < ApplicationRecord
  has_many :destinations
  has_many :users, through: :destinations
  validates :name, presence: true

  # # accepts_nested_attributes_for :destinations
  # def destinations_attributes=(destinations_attributes)
  #   destinations_attributes.each do |destination_attributes|
  #     self.destinations.build(destination_attributes)
  #   end
  # end
end
