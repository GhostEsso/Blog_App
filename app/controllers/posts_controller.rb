class PostsController < ApplicationController
  load_and_authorize_resource
  layout 'standard'
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: params[:user_id]).order(id: :asc)
    @posts = @posts.paginate(page: params[:page], per_page: 5)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      flash[:success] = 'Post Created!'
      redirect_to user_posts_url
    else
      flash.now[:error] = 'Error: Post can not be created!'
      render :new, locals: { post: @post }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.author.decrement!(:posts_counter)
    @post.destroy!
    flash[:success] = 'Post deleted successfully'
    redirect_to user_posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
