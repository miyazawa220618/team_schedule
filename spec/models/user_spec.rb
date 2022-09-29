require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての情報を適切に入力していれば登録できる' do
        expect(@user).to be_valid
      end
      it 'プロフィールテキストが無くても登録できる' do
        @user.profile_text = ''
        expect(@user).to be_valid
      end
      it 'プロフィール画像が無くても登録できる' do
        @user.profile_image = nil
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空の場合は登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it '同じnicknameを複数回登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Nickname has already been taken")
      end
      it 'emailが空の場合は登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '@が無いemailは登録できない' do
        @user.email = 'aaa.xxx.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it '同じemailを複数回登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'passwordが空の場合は登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'ab123'
        @user.password_confirmation = 'ab123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordは英字のみの文字列では登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordは数字のみの文字列では登録できない' do
        @user.password = '1234567890'
        @user.password_confirmation = '1234567890'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordは全角文字を含む場合は登録できない' do
        @user.password = 'ａbcd１２３４'
        @user.password_confirmation = 'ａbcd１２３４'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.save
        @user.password_confirmation = @user.password + 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'work_idが未選択の場合は登録できない' do
        @user.work_id = 1
        @user.valid?
        expect(@user.errors.full_messages).to include("Work can't be blank")
      end

    end
  end
end
