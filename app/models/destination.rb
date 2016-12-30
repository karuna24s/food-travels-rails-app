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

  def next
    # if the first destination is greater the current one exists then return the next destination
    if next_dest = self.class.where("id > ?", id).first
      next_dest
    else
      Destination.first
    end
  end

  def previous
    # if the destination is less then current one exists then return the previous destination
    if previous_dest = self.class.where("id < ?", id).last
      previous_dest
    else
      Destination.last
    end
  end

end
