class SharesController < ApplicationController
  before_action :set_share, only: [:edit, :update, :destroy]
  before_action :move_to_show, only: [:edit, :destroy]

  def create
    @share = Share.new(share_params)
    if @share.save
      redirect_to schedule_path(params[:schedule_id])
    end
  end

  def edit
    @schedule = Schedule.find(params[:schedule_id])
  end

  def update
    @share.memo_files.attach(params[:memo_files]) if @share.memo_files.blank?
    if @share.update(share_params)
      redirect_to schedule_path(params[:schedule_id])
    end
  end

  def destroy
    @share.destroy
    redirect_to schedule_path(params[:schedule_id])
  end

  private
  def share_params
    params.require(:share).permit(:share_date, :hour_id, :memo, {memo_files: []}).merge(user_id: current_user.id, schedule_id: params[:schedule_id])
  end

  def set_share
    @share = Share.find(params[:id])
  end

  def move_to_show
    redirect_to schedule_path(params[:schedule_id]) unless (user_signed_in? && current_user.id == @share.user_id)
end
end
