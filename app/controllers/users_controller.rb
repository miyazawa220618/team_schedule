class UsersController < ApplicationController
  before_action :move_to_index, only: [:index, :show]

  def index
  end

  def show
    @user = User.find(current_user.id)
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
