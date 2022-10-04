require 'rails_helper'

RSpec.describe Schedule, type: :model do
  before do
    @schedule = FactoryBot.build(:schedule)
  end

  describe 'スケジュールの新規作成' do
    context '新規作成できる場合' do
      it '全ての項目が適切に入力されている場合、作成できる' do
        expect(@schedule).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'titleが空の場合作成できない' do
        @schedule.title = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Title can't be blank")
      end
      it 'start_dateが未選択の場合作成できない' do
        @schedule.start_date = ''
        @schedule.end_date = Faker::Date.between(from: Date.today, to: '2022-12-01')
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Start date can't be blank")
      end
      it 'end_dateが未選択の場合作成できない' do
        @schedule.end_date = ''
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("End date can't be blank")
      end
      it 'end_dateがstart_dateより前の場合作成できない' do
        @schedule.end_date = @schedule.start_date - 1
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("End date must be greater than Project start")
      end
      it 'work_idが未選択の場合作成できない' do
        @schedule.work_id = 1
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Work can't be blank")
      end
      it 'projectが未選択の場合作成できない' do
        @schedule.project = nil
        @schedule.valid?
        expect(@schedule.errors.full_messages).to include("Project must exist")
      end
    end
  end
end
