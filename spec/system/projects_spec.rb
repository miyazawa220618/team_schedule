require 'rails_helper'

RSpec.describe "Projects", type: :system do

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  before do
    @project_user = FactoryBot.create(:project_user)
    @project_user_2 = FactoryBot.create(:project_user)
    @project_user_3 = FactoryBot.create(:project_user)
    @project = FactoryBot.build(:project)
    @another_project = FactoryBot.create(:project)
    @project_user_4 = FactoryBot.create(:project_user, project_id: @another_project.id)
  end

  context 'プロジェクトが新規作成できるとき' do
    it 'ログインしたユーザーは、新規作成できてプロジェクト一覧画面に移動する' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # プロジェクト一覧画面へのボタンがあることを確認する
      expect(page).to have_content('プロジェクト')
      # プロジェクト一覧画面へ移動する
      click_link 'プロジェクト'
      expect(current_path).to eq(projects_path)
      # プロジェクト新規作成ボタンがあることを確認する
      expect(page).to have_content('プロジェクト作成')
      # 新規作成ページへ移動する
      click_link 'プロジェクト作成'
      expect(current_path).to eq(new_project_path)
      # フォームに情報を入力する
      fill_in 'project[name]', with: @project.name
      fill_in 'project[about]', with: @project.about
      attach_file 'project_file_0', 'public/images/sample1.png'
      attach_file 'project_file_1', 'public/images/sample2.png'
      attach_file 'project_file_2', 'public/images/sample3.jpg'
      attach_file 'project_file_3', 'public/images/last_subject_material.pdf'
      attach_file 'project_file_4', 'public/images/test_schedule.xlsx'
      fill_in 'project[project_start]', with: @project.project_start
      fill_in 'project[project_end]', with: @project.project_end
      find('label[for='"project_user_ids_#{@project_user_2.user_id}"']').click
      find('label[for='"project_user_ids_#{@project_user_3.user_id}"']').click
      find('#project_member_flag', visible: false).click
      # 送信するとProjectモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(1)
      # プロジェクト一覧画面へ遷移することを確認する
      expect(current_path).to eq(projects_path)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（プロジェクト名）
      expect(page).to have_content(@project.name)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（開始日）
      expect(page).to have_content(@project.project_start)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（FIX予定日）
      expect(page).to have_content(@project.project_end)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（メンバー画像）
      expect(page).to have_selector("img[src$='#{@project_user.user.profile_image.filename}']")
      expect(page).to have_selector("img[src$='#{@project_user_2.user.profile_image.filename}']")
      expect(page).to have_selector("img[src$='#{@project_user_3.user.profile_image.filename}']")
    end

    it 'プロジェクト作成の際に、詳細テキスト、添付ファイル、メンバー選択、メンバー募集を選択しなくても登録できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # プロジェクト一覧画面へのボタンがあることを確認する
      expect(page).to have_content('プロジェクト')
      # プロジェクト一覧画面へ移動する
      click_link 'プロジェクト'
      expect(current_path).to eq(projects_path)
      # プロジェクト新規作成ボタンがあることを確認する
      expect(page).to have_content('プロジェクト作成')
      # 新規作成ページへ移動する
      click_link 'プロジェクト作成'
      expect(current_path).to eq(new_project_path)
      # フォームに情報を入力する
      fill_in 'project[name]', with: @project.name
      fill_in 'project[project_start]', with: @project.project_start
      fill_in 'project[project_end]', with: @project.project_end
      # 送信するとProjectモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(1)
      # プロジェクト一覧画面へ遷移することを確認する
      expect(current_path).to eq(projects_path)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（プロジェクト名）
      expect(page).to have_content(@project.name)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（開始日）
      expect(page).to have_content(@project.project_start)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（FIX予定日）
      expect(page).to have_content(@project.project_end)
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（メンバー画像）
      expect(page).to have_selector("img[src$='#{@project_user.user.profile_image.filename}']")
    end
  end

  context 'プロジェクトが新規作成できないとき' do
    it 'ログインしてないユーザーは、プロジェクト作成画面に遷移できない' do
      # ルートパスにアクセスする
      basic_pass root_path
      visit root_path
      # ログインせずプロジェクト作成画面に遷移する
      visit new_project_path
      # ログイン画面にリダイレクトする
      expect(current_path).to eq(new_user_session_path)
    end
    it 'ログインしたユーザーは、入力内容に不備がある場合は新規作成できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # プロジェクト一覧画面へのボタンがあることを確認する
      expect(page).to have_content('プロジェクト')
      # プロジェクト一覧画面へ移動する
      click_link 'プロジェクト'
      expect(current_path).to eq(projects_path)
      # プロジェクト新規作成ボタンがあることを確認する
      expect(page).to have_content('プロジェクト作成')
      # 新規作成ページへ移動する
      click_link 'プロジェクト作成'
      expect(current_path).to eq(new_project_path)
      # フォームに情報を入力する
      fill_in 'project[name]', with: @project.name
      # 送信してもProjectモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(0)
      # プロジェクト新規作成画面に戻されることを確認する
      expect(current_path).to eq(projects_path)
    end
    it 'ログインしたユーザーは、FIX予定日を開始日よりも前に設定した場合は新規作成できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # プロジェクト一覧画面へのボタンがあることを確認する
      expect(page).to have_content('プロジェクト')
      # プロジェクト一覧画面へ移動する
      click_link 'プロジェクト'
      expect(current_path).to eq(projects_path)
      # プロジェクト新規作成ボタンがあることを確認する
      expect(page).to have_content('プロジェクト作成')
      # 新規作成ページへ移動する
      click_link 'プロジェクト作成'
      expect(current_path).to eq(new_project_path)
      # フォームに情報を入力する
      fill_in 'project[name]', with: @project.name
      fill_in 'project[project_start]', with: @project.project_start
      fill_in 'project[project_end]', with: @project.project_start - 1
      # 送信してもProjectモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(0)
      # プロジェクト新規作成画面に戻されることを確認する
      expect(current_path).to eq(projects_path)
    end
  end

  context 'プロジェクトを編集できるとき' do
    it 'ログインしたユーザーは自身が登録したプロジェクト情報を編集できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user_4.user.email
      fill_in 'user[password]', with: @project_user_4.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user_4.user.id))
      # プロジェクト詳細画面へ移動する
      click_link 'プロジェクト'
      click_link @another_project.name
      expect(current_path).to eq(project_path(@another_project.id))
      # 編集画面に移動する
      click_link '編集'
      expect(current_path).to eq(edit_project_path(@another_project.id))
      # 登録済みの情報を編集する
      fill_in 'project[name]', with: @project.name + '修正しました'
      # 送信してもProjectモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(0)
      # プロジェクト詳細画面に移動していることを確認する
      expect(current_path).to eq(project_path(@another_project.id))
      # 詳細画面に先程修正した名前のプロジェクト名になっていることを確認する
      expect(page).to have_content(@project.name + '修正しました')
    end
  end

  context 'プロジェクトを編集できないとき' do
    it 'ログインしていないユーザーはプロジェクト情報を編集できない' do
      # ルートパスに遷移する
      basic_pass root_path
      visit root_path
      # ログインせずに編集画面にアクセスする
      visit edit_project_path(@another_project.id)
      # ログイン画面にリダイレクトされていることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
    it 'プロジェクト作成者以外のユーザーはプロジェクト情報を編集できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user.id))
      # プロジェクト詳細画面へ移動する
      click_link 'プロジェクト'
      click_link @another_project.name
      expect(current_path).to eq(project_path(@another_project.id))
      # 編集ボタンか存在しないことを確認する
      expect(page).to have_no_link '編集', href: edit_project_path(@another_project.id)
      # 編集画面にアクセスする
      visit edit_project_path(@another_project.id)
      # 詳細画面にリダイレクトされる
      expect(current_path).to eq(project_path(@another_project.id))
    end
    it '誤った情報を入力した場合はプロジェクト情報を編集できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user_4.user.email
      fill_in 'user[password]', with: @project_user_4.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user_4.user.id))
      # プロジェクト詳細画面へ移動する
      click_link 'プロジェクト'
      click_link @another_project.name
      expect(current_path).to eq(project_path(@another_project.id))
      # 編集画面にアクセスする
      click_link '編集'
      expect(current_path).to eq(edit_project_path(@another_project.id))
      # 登録済みの情報を修正する
      fill_in 'project[name]', with: ''
      # 送信してもProjectモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Project.count }.by(0)
      # プロジェクト編集画面に戻されることを確認する
      expect(current_path).to eq(project_path(@another_project.id))
      # エラーテキストが表示されていることを確認する
      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'プロジェクトを削除できるとき' do
    it 'ログインしたユーザーは自身が登録したプロジェクト情報を削除できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user_4.user.email
      fill_in 'user[password]', with: @project_user_4.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user_4.user.id))
      # プロジェクト詳細画面へ移動する
      click_link 'プロジェクト'
      click_link @another_project.name
      expect(current_path).to eq(project_path(@another_project.id))
      # 削除ボタンをクリックするとProjectモデルのカウントが1つ少なくなったことを確認する
      expect{
        click_link '削除'
      }.to change { Project.count }.by(-1)
      # プロジェクト一覧画面に移動していることを確認する
      expect(current_path).to eq(projects_path)
      # 一覧画面から先程削除したプロジェクトがなくなっていることを確認する
      expect(page).to have_no_content(@another_project.name)
    end
  end

  context 'プロジェクトを削除できないとき' do
    it 'ログインしていないユーザーはプロジェクト情報を削除できない' do
      # ルートパスに遷移する
      basic_pass root_path
      visit root_path
      # 削除リンクにアクセスしてもProjectモデルのカウントが変わらないことを確認する
      expect{
        delete project_path(@another_project.id)
      }.to change { Project.count }.by(0)
      # ログイン画面にリダイレクトされていることを確認する
      expect(current_path).to eq(root_path)
    end
    it 'プロジェクトの作成者以外は削除できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user.id))
      # プロジェクト詳細画面へ移動する
      click_link 'プロジェクト'
      click_link @another_project.name
      expect(current_path).to eq(project_path(@another_project.id))
      # 削除ボタンが存在しないことを確認する
      expect(page).to have_no_link '削除', href: project_path(@another_project.id)
      # 削除リンクにアクセスしてもProjectモデルのカウントが変わらないことを確認する
      expect{
        delete project_path(@another_project.id)
      }.to change { Project.count }.by(0)
      # 詳細画面に戻されることを確認する
      expect(current_path).to eq(project_path(@another_project.id))
    end
  end
end
