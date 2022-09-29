class ProjectsController < ApplicationController
  before_action :move_to_index, only: [:index]
  def index
    
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end
end
