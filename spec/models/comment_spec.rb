require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント新規作成' do
    context 'コメントが作成できる場合' do
      it 'テキストエリアに適切に入力されている場合作成できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが作成できない場合' do
      it 'textが空の場合は作成できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text can't be blank")
      end
      it 'userと紐づいてなければ投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User must exist")
      end
      it 'projectと紐づいてなければ投稿できない' do
        @comment.project = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Project must exist")
      end
    end
  end
end
