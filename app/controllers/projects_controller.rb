class ProjectsController < ApplicationController
  before_action :move_to_index

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
    @project = Project.find(params[:id])
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def project_params
    params.require(:project).permit(:name, :about, :project_start, :project_end, {files: []}, {user_ids: []}, :member_flag)
  end
end
