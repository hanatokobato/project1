class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :destroy, :following, :followers]
  before_action :verify_admin!, only: :destroy

  def index
    @users = User.select(:id, :name, :email).order(:name)
      .paginate page: params[:page], per_page: Settings.users.index.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".failed"
      render :new
    end
  end

  def show
    @posts = @user.posts.paginate page: params[:page],
      per_page: Settings.post.per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".can_not_delete"
    end
    redirect_to users_url
  end

  def following
    @title = t ".following"
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = t ".followers"
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]

    return if current_user.is_user? @user
    flash[:danger] = t ".cannot_change_another"
    redirect_to root_url
  end

  def verify_admin!
    rerurn if current_user.admin?
    flash[:danger] = t ".you_are_not_admin"
    redirect_to root_url
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
