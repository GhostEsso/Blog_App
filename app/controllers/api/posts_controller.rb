class Api::PostsController < Api::ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
    render json: @posts, status: :ok
  end
end
