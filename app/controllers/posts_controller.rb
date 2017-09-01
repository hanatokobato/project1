class PostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".created"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Deleted"
    else
      flash[:danger] = "Failed"
    end

    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit :title, :body, :picture
  end

  def correct_user
    @post = current_user.posts.find_by id: params[:id]
    redirect_to root_url if @post.nil?
  end
end
