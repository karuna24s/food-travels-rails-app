class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :location, :recommendation, :comment_list
  has_one :food
  has_one :user

  def comment_list
    object.comments.map do |comment|
      {
        id: comment.id,
        user: {
          id: comment.user_id,
          name: User.find(comment.user_id).name
        },
        content: comment.content
      }
    end
  end
end
