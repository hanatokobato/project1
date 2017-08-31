class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_commentable
  before_action :verify_create, only: :create
  before_action :verify_destroy, only: :destroy

  def index
    @comments = @commentable.comments

    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @commentable.comments.build comment_params
    @comment.user_id = current_user.id

    if @comment.save
      respond_to {|format| format.js}
    end
  end

  def destroy
    @comment.destroy
    respond_to {|format| format.js}
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_commentable
    @post = Post.find_by id: params[:post_id] if params[:post_id]
    if params[:comment_id]
      @commentable = Comment.find_by id: params[:comment_id]
      return
    end
    @commentable = @post
  end

  def verify_create
    unless current_user.is_user?(@post.user) || current_user.following?(@post.user)
      flash[:danger] = t ".can_not_comment"
      redirect_to request.referrer || root_url
    end
  end

  def verify_destroy
    @comment = @commentable.comments.find_by id: params[:id]

    return if current_user.is_user?(@comment.user) || current_user.is_user?(@post.user)
    flash[:danger] = t ".can_not_delete"
    redirect_to request.referrer || root_url
  end
end
