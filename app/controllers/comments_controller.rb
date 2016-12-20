class CommentsController < ApplicationController
  before_action :set_destination

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.destination = @destination
    @comment.save
    render json: @comment, status: 201
  end



  private

  def set_destination
    @destination = Destination.find(params[:destination_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
