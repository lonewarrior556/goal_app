class UsersController < ApplicationController

  before_action :redirect_if_not_logged_in, only: [:show, :index, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update

  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_in?
  end





end
