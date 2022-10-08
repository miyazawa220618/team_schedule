class UsersController < ApplicationController
  before_action :move_to_index, only: [:index, :show]

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    date = Date.today
    shares = @user.shares.where(share_date: [(date)..(date.since(6.days))]).order(share_date: "ASC")

    @today = Date.today-1
    num = 0
    i = 1
    7.times do
      num += 1
      unless (@today+num).saturday? || (@today+num).sunday?
        instance_variable_set("@day#{i}", @today + num)
        i += 1
      end
    end
    @dat_week = ['SUN','MON','TUE','WED','THE','FRI','SAT']
    1..5.times do |num|
      num += 1
      instance_variable_set("@share#{num}", [])
      instance_variable_set("@hour#{num}", 0)
    end
    shares.each do |share|
      if share.share_date == @day1
        @share1.push(share)
        @hour1 += share.hour.name.to_f
      elsif share.share_date == @day2
        @share2.push(share)
        @hour2 += share.hour.name.to_f
      elsif share.share_date == @day3
        @share3.push(share)
        @hour3 += share.hour.name.to_f
      elsif share.share_date == @day4
        @share4.push(share)
        @hour4 += share.hour.name.to_f
      elsif share.share_date == @day5
        @share5.push(share)
        @hour5 += share.hour.name.to_f
      end
    end
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

end
