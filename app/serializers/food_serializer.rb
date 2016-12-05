class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :category
  has_many :reviews
end
