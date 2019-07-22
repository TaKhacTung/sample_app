class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(index edit update destroy)
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  before_action :load_user, only: [:destroy]
  def index
    @users = User.all.page(params[:page]).per Settings.paginate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "static_pages.home.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]

    return if @user
    flash.now[:danger] = t("user.show.not_exits")
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controllers.user.success"
      redirect_to @user
    else
      flash.now[:danger] = t "controllers.user.fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("controllers.user.delete_s")
    else
      flash[:danger] = t("controllers.user.delete_er")
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "require_login"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t("controllers.user.not_exits")
    redirect_to root_path
    end
end
