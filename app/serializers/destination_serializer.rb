class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :location, :recommendation
  has_one :food
  has_one :user
  has_many :comments
end
