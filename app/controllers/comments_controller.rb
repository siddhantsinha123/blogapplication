class CommentsController < ApplicationController
before_action :find_commentable, only: :create
before_action :authenticate_user!, only: %i[ create new ]

    def new
      @comment = Comment.new
    end

    def create

      comment = @commentable.comments.build(comment_params.merge(user: current_user))
      if params[:comment_id]
        comment.blog= @commentable.blog if params[:comment_id]
        @blog = @commentable.blog
      else
        @blog = @commentable
      end

      if comment.save
        flash[:success] = "successfully save"
        redirect_to @blog
      else
        flash[:error] = comment.errors.full_messages
        @blog = @blog
        render :template => "blogs/show"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_commentable
    	
      if params[:comment_id]
        @commentable = Comment.find_by_id(params[:comment_id])
      elsif params[:blog_id]
        @commentable = Blog.find_by_id(params[:blog_id])
      end
    end

end