class SchedulesController < ApplicationController

  def index
    
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to schedules_path
    else
      render :new
    end
  end

  private
  def schedule_params
    params.require(:schedule).permit(:title, :start_date, :end_date, :work_id, :project_id)
  end
end
