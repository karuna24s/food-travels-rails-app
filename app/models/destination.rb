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

  # def next(id)
  #   next_dest = nil
  #   # binding.pry
  #   Destination.all.each.with_index do |destination, index|
  #     # binding.pry
  #     if id == destination.id
  #       next_dest = Destination.all[index + 1]
  #       return next_dest
  #     end
  #   end
  #   return nil
  # end
  def next
    if next_dest = self.class.where("id > ?", id).first
      next_dest
    else
      Destination.first
    end
  end

  def previous
    if previous_dest = self.class.where("id < ?", id).last
      previous_dest
    else
      Destination.last
    end
  end



  # def previous(id)
  #   previous_dest = nil
  #   # binding.pry
  #   Destination.all.each.with_index do |destination, index|
  #     # binding.pry
  #     if id == destination.id
  #       previous_dest = Destination.all[index - 1]
  #       return previous_dest
  #     end
  #   end
  #   return nil
  # end

end
