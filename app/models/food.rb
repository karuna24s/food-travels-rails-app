class Food < ApplicationRecord
  validates :name, presence: true
  has_many :destinations
  has_many :users, through: :destinations

  # accepts_nested_attributes_for :destinations
  def destinations_attributes=(destinations_attributes)
    destinations_attributes.values.each do |destination_attributes|
      raise params.inspect
      self.reviews.build(destination_attributes)
    end
  end
end
