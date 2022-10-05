require 'rails_helper'

RSpec.describe Share, type: :model do
  before do
    @share = FactoryBot.build(:share)
  end

  describe '作業分担メモの新規投稿' do
    context '新規投稿できる場合' do
      it '全ての項目が適切に入力されていれば投稿できる' do
        expect(@share).to be_valid
      end
      it '作業メモが空でも投稿できる' do
        @share.memo = ''
        expect(@share).to be_valid
      end
      it '添付が無くても投稿できる' do
        @share.memo_files = nil
        expect(@share).to be_valid
      end
    end

    context '新規投稿できない場合' do
      it 'share_dateが未選択の場合は投稿できない' do
        @share.share_date = ''
        @share.valid?
        expect(@share.errors.full_messages).to include("Share date can't be blank")
      end
      it 'hour_idが未選択の場合は投稿できない' do
        @share.hour_id = 1
        @share.valid?
        expect(@share.errors.full_messages).to include("Hour can't be blank")
      end
      it 'scheduleと紐づいてなければ投稿できない' do
        @share.schedule = nil
        @share.valid?
        expect(@share.errors.full_messages).to include("Schedule must exist")
      end
      it 'userと紐づいてなければ投稿できない' do
        @share.user = nil
        @share.valid?
        expect(@share.errors.full_messages).to include("User must exist")
      end
    end
  end
end
