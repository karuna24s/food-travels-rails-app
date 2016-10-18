class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create(comment_params)
    # binding.pry
    redirect_to destination_path(@comment.destination)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :destination_id, :user_id, user_attributes:[:name])
  end
end
