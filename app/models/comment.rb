class Comment < ApplicationRecord
  validates :content, presence: true
end
