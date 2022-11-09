require 'rails_helper'

RSpec.describe "Users", type: :system do

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @other_user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '正しい情報を入力した場合、新規登録が完了後にマイページに遷移され、一覧画面に情報が追加される' do
        # ログイン画面にアクセスする
        basic_pass root_path
        visit root_path
        # 新規登録ボタンをクリックする
        click_link '新規登録'
        # 新規登録画面に遷移したことを確認する
        expect(current_path).to eq(new_user_registration_path)
        # 正しいユーザー情報を入力する
        fill_in 'user[nickname]', with: @other_user.nickname
        fill_in 'user[email]', with: @other_user.email
        fill_in 'user[password]', with: @other_user.password
        fill_in 'user[password_confirmation]', with: @other_user.password_confirmation
        select @other_user.work.name, from: 'user[work_id]'
        fill_in 'user[profile_text]', with: @other_user.profile_text
        attach_file 'user[profile_image]', 'public/images/sample1.png'
        # 上記の内容で登録するボタンをクリックするとUserモデルのカウントが1上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
        # マイページへ遷移したことを確認する
        expect(current_path).to eq(user_path(@user.id + 2))
        # メンバーリストはこちらボタンをクリックする
        click_link 'メンバーリストはこちら'
        # メンバーリスト画面に遷移したことを確認する
        expect(current_path).to eq(users_path)
        # 先程登録したニックネームが表示されていることを確認する
        expect(page).to have_content(@other_user.nickname)
      end
    end

    context '新規登録できないとき' do
      it '誤ったユーザー情報を入力した場合、登録完了できず新規登録画面に戻る' do
        # ログイン画面にアクセスする
        basic_pass root_path
        visit root_path
        # 新規登録ボタンをクリックする
        click_link '新規登録'
        # 新規登録画面に遷移したことを確認する
        expect(current_path).to eq(new_user_registration_path)
        # 誤ったユーザー情報を入力する
        fill_in 'user[nickname]', with: @other_user.nickname
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @other_user.password
        fill_in 'user[password_confirmation]', with: @other_user.password_confirmation
        select @other_user.work.name, from: 'user[work_id]'
        # 上記の内容で登録するボタンをクリックしてもUserモデルのカウントが上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # 新規登録画面へ戻されることを確認する
        expect(current_path).to eq(user_registration_path)
      end
    end
  end

  describe 'ログイン' do
    context 'ログインできるとき' do
      it '正しい情報を入力した場合、新規登録が完了後にマイページに遷移され、マイスケジュールへのリンクが設置される' do
        # ログイン画面にアクセスする
        basic_pass root_path
        visit root_path
        # 正しいログイン情報を入力する
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        # ログインボタンをクリックする
        find('input[name="commit"]').click
        # マイページ画面へ遷移したことを確認する
        expect(current_path).to eq(user_path(@user.id))
        # 新規登録のボタンがないことを確認する
        expect(page).to have_no_content('新規登録')
        # プロジェクト、スケジュール、マイページ、ログアウトのボタンがあることを確認する
        expect(page).to have_content('プロジェクト')
        expect(page).to have_content('スケジュール')
        expect(page).to have_content('マイページ')
        expect(page).to have_content('ログアウト')
        # マイスケジュールのリンクに自身のuseridのパラメーターがついていることを確認する
        expect(page).to have_link 'マイスケジュール', href: "/schedules?q%5Bwork_id_eq%5D=&q%5Bshares_user_id_eq%5D=#{@user.id}&q%5Bproject_name_or_title_or_shares_memo_cont%5D=&commit=検索"
        # マイスケジュールボタンをクリックする
        click_link 'マイスケジュール'
        # スケジュール一覧画面に遷移したことを確認する
        expect(current_path).to eq(schedules_path)
        # 検索欄のメンバー選択に自身の名前が選択状態になっていることを確認する
        expect(page).to have_select('q[shares_user_id_eq]', selected: @user.nickname)
      end
    end

    context 'ログインできないとき' do
      it '誤った情報を入力した場合、ログインできずログイン画面に戻る' do
        # ログイン画面にアクセスする
        basic_pass root_path
        visit root_path
        # ユーザー情報を入力する
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: @user.password
        # 上記の内容で登録するボタンをクリックする
        find('input[name="commit"]').click
        # ログイン画面へ戻されることを確認する
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'ユーザー情報の編集' do
    context '編集できるとき' do
      it 'ログインしたユーザーは自身のユーザー情報を編集できる' do
        # 登録済みのユーザーでログインする
        basic_pass root_path
        visit root_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        find('input[name="commit"]').click
        # マイページに遷移したことを確認する
        expect(current_path).to eq(user_path(@user.id))
        # マイページに編集ボタンがあることを確認する
        expect(page).to have_content('編集')
        # 編集ボタンをクリックする
        click_link '編集'
        # 編集画面に遷移したことを確認する
        expect(current_path).to eq(edit_user_registration_path)
        # 既に登録済みの情報がフォームに入っていることを確認する
        expect(find('input[name="user[nickname]"]').value).to eq(@user.nickname)
        expect(find('input[name="user[email]"]').value).to eq(@user.email)
        expect(find('select[name="user[work_id]"]').value).to eq(@user.work_id.to_s)
        expect(find('textarea[name="user[profile_text]"]').value).to eq(@user.profile_text)
        # 登録内容を編集する
        fill_in 'user[current_password]', with: @user.password
        fill_in 'user[profile_text]', with: @user.profile_text + '編集しました'
        attach_file 'user[profile_image]', 'public/images/sample2.png'
        # 編集してもUserモデルのカウントは変わらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
        # マイページに遷移したことを確認する
        expect(current_path).to eq(user_path(@user.id))
        # マイページには先ほど変更した情報が表示されていることを確認する
        expect(page).to have_content(@user.profile_text + '編集しました')
        expect(page).to have_selector("img[src$='sample2.png']")
      end
    end

    context '編集できないとき' do
      it 'ログインしていないユーザーは編集画面に遷移できない' do
        # ログイン画面にアクセスする
        basic_pass root_path
        visit root_path
        # ログインせずユーザー編集画面にアクセスする
        visit edit_user_registration_path
        # ログイン画面にリダイレクトされる
        expect(current_path).to eq(new_user_session_path)
      end

      it '自分以外のユーザーのユーザー編集画面へ遷移できない' do
        # user2のユーザーでログインする
        basic_pass root_path
        visit root_path
        fill_in 'user[email]', with: @user2.email
        fill_in 'user[password]', with: @user2.password
        find('input[name="commit"]').click
        # マイページに遷移することを確認する
        expect(current_path).to eq(user_path(@user2.id))
        # 他のユーザーのマイページに移動する
        visit user_path(@user.id)
        # 編集ボタンがないことを確認する
        expect(page).to have_no_content('編集')
      end
    end
  end
end
