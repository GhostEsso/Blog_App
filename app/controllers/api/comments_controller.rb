class Api::CommentsController < Api::ApplicationController
  def index
    @comments = Comment.where(post_id: params[:post_id]).order(id: :asc)
    render json: @comments, status: :ok
  end

  def create
    @comment = Comment.new(user_id: current_user.id, post_id: comment_params[:post_id], text: comment_params[:text])

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:text, :post_id)
  end
end
