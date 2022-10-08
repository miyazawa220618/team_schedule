class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :move_to_show, only: [:edit, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to project_path(params[:project_id])
    end
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to project_path(params[:project_id])
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_path(params[:project_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, project_id: params[:project_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def move_to_show
    redirect_to project_path(params[:project_id]) unless (user_signed_in? && current_user.id == @comment.user_id)
  end
end
