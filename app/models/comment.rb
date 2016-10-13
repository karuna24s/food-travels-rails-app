class Comment < ApplicationRecord
  belongs_to :destination
  belongs_to :user
  validates :content, presence: true
end
