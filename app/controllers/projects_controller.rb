class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :move_to_show, only: [:edit, :update, :destroy]

  def index
    projects = Project.all
    @project_after = Project.where("project_start > ?", Date.today)
    @project_now = Project.where("project_start <= ? and project_end >= ?", Date.today, Date.today)

    @project_before = []
    projects.each do |project|
      if Date.today.between?( project[:project_end] , (project[:project_end] + 40))
        @project_before.push(project)
      end
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save(context: :project)
      redirect_to projects_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @project.files.attach(params[:files]) if @project.files.blank?

    @project.attributes = project_params
    if @project.save(context: :project)
      redirect_to project_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private
  def project_params
    params.require(:project).permit(:name, :about, :project_start, :project_end, {files: []}, {user_ids: []}, :member_flag)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def move_to_show
      last_user = (@project.users.length) - 1
      redirect_to action: :show unless (user_signed_in? && current_user.id == @project.users.ids[last_user])
  end
end
