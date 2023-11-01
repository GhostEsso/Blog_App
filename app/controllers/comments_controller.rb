class CommentsController < ApplicationController
    layout 'standard'
    def new
      @comment = Comment.new
    end
  
    def create
      @comment = Comment.new(params.require(:comment).permit(:text, :user_id, :post_id))
      if @comment.save
        flash[:success] = 'Comment created!'
        redirect_to "/users/#{@comment.user_id}/posts/#{@comment.post_id}"
      else
        flash.now[:error] = 'Error: Comment can not be created!'
        render :new, locals: { comment: @comment }
      end
    end
  end
