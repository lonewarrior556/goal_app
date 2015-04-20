class CommentsController < ApplicationController

  def create
    if params[:comment][:user_id].nil?
      @comment = current_user.authored_goal_comments.new(comment_params)
      type = "goal"
      id = @comment.goal_id
    else
      @comment = current_user.authored_user_comments.new(comment_params)
      type = "user"
      id = @comment.user_id
    end
    flash[:errors] = ["Comment Can't be blank"] unless @comment.save
    redirect_to send("#{type}_url", id)
  end




  def destroy

    if params[:comment][:type] == "user"
      @comment = UserComment.find(params[:id])
      @comment.destroy!
      redirect_to user_url(@comment.user_id)
    else
      @comment = GoalComment.find(params[:id])
      @comment.destroy!
      redirect_to goal_url(@comment.goal_id)
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :goal_id)
  end

end
