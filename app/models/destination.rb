class Destination < ApplicationRecord
  belongs_to :food
  belongs_to :user
  has_many :comments
  validates_presence_of :title, :content, :location

  def food_attributes=(food_attributes)
    self.food = Food.where(:name => food_attributes[:name]).first_or_create do |f|
      f.category = food_attributes[:category]
    end
  end
  
end
