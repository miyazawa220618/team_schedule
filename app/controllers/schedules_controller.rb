class SchedulesController < ApplicationController

  def index
    @schedules = Schedule.all
    @today = Date.today
    @monday = Date.today.beginning_of_week
    @dat_week = ['SUN','MON','TUE','WED','THE','FRI','SAT']

    base_week = @monday - 42

    @holiday = []
    at_day = @today - 36
    115.times do 
      at_day += 1
      if HolidayJapan.check(at_day)
        @holiday.push(at_day)
      end
    end

    1..15.times do |num|
      base_week = base_week + 7
      instance_variable_set("@base_week#{num}", base_week)
      instance_variable_set("@mon_schedule#{num}", [])
      instance_variable_set("@tue_schedule#{num}", [])
      instance_variable_set("@wed_schedule#{num}", [])
      instance_variable_set("@thu_schedule#{num}", [])
      instance_variable_set("@fri_schedule#{num}", [])
    end

    # 5週間前
    @schedules.each do |s|
      if (@base_week0.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule0.push(s)
      elsif ((@base_week0+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule0.push(s)
      elsif ((@base_week0+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule0.push(s)
      elsif ((@base_week0+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule0.push(s)
      elsif ((@base_week0+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule0.push(s)
      end
    end

    # 4週間前
    @schedules.each do |s|
      if (@base_week1.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule1.push(s)
      elsif ((@base_week1+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule1.push(s)
      elsif ((@base_week1+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule1.push(s)
      elsif ((@base_week1+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule1.push(s)
      elsif ((@base_week1+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule1.push(s)
      end
    end

    # 3週間前
    @schedules.each do |s|
      if (@base_week2.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule2.push(s)
      elsif ((@base_week2+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule2.push(s)
      elsif ((@base_week2+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule2.push(s)
      elsif ((@base_week2+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule2.push(s)
      elsif ((@base_week2+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule2.push(s)
      end
    end

    # 2週間前
    @schedules.each do |s|
      if (@base_week3.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule3.push(s)
      elsif ((@base_week3+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule3.push(s)
      elsif ((@base_week3+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule3.push(s)
      elsif ((@base_week3+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule3.push(s)
      elsif ((@base_week3+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule3.push(s)
      end
    end

    # 1週間前
    @schedules.each do |s|
      if (@base_week4.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule4.push(s)
      elsif ((@base_week4+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule4.push(s)
      elsif ((@base_week4+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule4.push(s)
      elsif ((@base_week4+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule4.push(s)
      elsif ((@base_week4+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule4.push(s)
      end
    end

    # 今週
    @schedules.each do |s|
      if (@base_week5.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule5.push(s)
      elsif ((@base_week5+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule5.push(s)
      elsif ((@base_week5+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule5.push(s)
      elsif ((@base_week5+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule5.push(s)
      elsif ((@base_week5+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule5.push(s)
      end
    end

    # 来週
    @schedules.each do |s|
      if (@base_week6.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule6.push(s)
      elsif ((@base_week6+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule6.push(s)
      elsif ((@base_week6+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule6.push(s)
      elsif ((@base_week6+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule6.push(s)
      elsif ((@base_week6+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule6.push(s)
      end
    end

    # 2週間後
    @schedules.each do |s|
      if (@base_week7.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule7.push(s)
      elsif ((@base_week7+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule7.push(s)
      elsif ((@base_week7+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule7.push(s)
      elsif ((@base_week7+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule7.push(s)
      elsif ((@base_week7+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule7.push(s)
      end
    end

    # 3週間後
    @schedules.each do |s|
      if (@base_week8.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule8.push(s)
      elsif ((@base_week8+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule8.push(s)
      elsif ((@base_week8+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule8.push(s)
      elsif ((@base_week8+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule8.push(s)
      elsif ((@base_week8+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule8.push(s)
      end
    end

    # 4週間後
    @schedules.each do |s|
      if (@base_week9.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule9.push(s)
      elsif ((@base_week9+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule9.push(s)
      elsif ((@base_week9+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule9.push(s)
      elsif ((@base_week9+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule9.push(s)
      elsif ((@base_week9+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule9.push(s)
      end
    end

    # 5週間後
    @schedules.each do |s|
      if (@base_week10.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule10.push(s)
      elsif ((@base_week10+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule10.push(s)
      elsif ((@base_week10+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule10.push(s)
      elsif ((@base_week10+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule10.push(s)
      elsif ((@base_week10+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule10.push(s)
      end
    end

    # 6週間後
    @schedules.each do |s|
      if (@base_week11.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule11.push(s)
      elsif ((@base_week11+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule11.push(s)
      elsif ((@base_week11+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule11.push(s)
      elsif ((@base_week11+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule11.push(s)
      elsif ((@base_week11+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule11.push(s)
      end
    end

    # 7週間後
    @schedules.each do |s|
      if (@base_week12.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule12.push(s)
      elsif ((@base_week12+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule12.push(s)
      elsif ((@base_week12+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule12.push(s)
      elsif ((@base_week12+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule12.push(s)
      elsif ((@base_week12+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule12.push(s)
      end
    end

    # 8週間後
    @schedules.each do |s|
      if (@base_week13.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule13.push(s)
      elsif ((@base_week13+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule13.push(s)
      elsif ((@base_week13+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule13.push(s)
      elsif ((@base_week13+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule13.push(s)
      elsif ((@base_week13+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule13.push(s)
      end
    end

    # 9週間後
    @schedules.each do |s|
      if (@base_week14.between?(Date.parse(s[:start_date].to_s), Date.parse(s[:end_date].to_s)))
        @mon_schedule14.push(s)
      elsif ((@base_week14+1) == (Date.parse(s[:start_date].to_s)))
        @tue_schedule14.push(s)
      elsif ((@base_week14+2) == (Date.parse(s[:start_date].to_s)))
        @wed_schedule14.push(s)
      elsif ((@base_week14+3) == (Date.parse(s[:start_date].to_s)))
        @thu_schedule14.push(s)
      elsif ((@base_week14+4) == (Date.parse(s[:start_date].to_s)))
        @fri_schedule14.push(s)
      end
    end

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
