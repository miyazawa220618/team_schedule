class SharesController < ApplicationController
  def create
    @share = Share.new(share_params)
    if @share.save
      redirect_to schedule_path(params[:schedule_id])
    end
  end

  def edit
    @schedule = Schedule.find(params[:schedule_id])
    @share = Share.find(params[:id])
  end

  def update
    @share = Share.find(params[:id])
    @share.memo_files.attach(params[:memo_files]) if @share.memo_files.blank?
    if @share.update(share_params)
      redirect_to schedule_path(params[:schedule_id])
    end
  end

  private
  def share_params
    params.require(:share).permit(:share_date, :hour_id, :memo, {memo_files: []}).merge(user_id: current_user.id, schedule_id: params[:schedule_id])
  end
end
