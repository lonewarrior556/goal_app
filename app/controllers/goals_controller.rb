class GoalsController < ApplicationController

  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]
  before_action :redirect_if_private, only: [:show]

  def new
    @goal = Goal.new
    render :new
  end

  def show
    @goal = Goal.find(params[:id])
    @comments = @goal.comments
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy!
    redirect_to user_url(@goal.user_id)
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :private)
  end

  def redirect_if_not_owner
    @goal = Goal.find(params[:id])
    redirect_to users_url if @goal.user_id != current_user.id
  end

  def redirect_if_private
    @goal = Goal.find(params[:id])
    redirect_if_not_owner if @goal.private
  end

end
