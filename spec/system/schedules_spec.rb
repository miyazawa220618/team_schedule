require 'rails_helper'

RSpec.describe "Schedules", type: :system do
  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  describe 'schedule新規作成' do
    context '新規作成できるとき' do
      before do
        @project = FactoryBot.create(:project, project_start: Date.today, project_end: Date.today + 3)
        @project_user = FactoryBot.create(:project_user, project_id: @project.id)
        @schedule = FactoryBot.build(:schedule, project_id: @project.id)
      end

      it 'ログインしたユーザーは、プロジェクトの作成がある場合に新規作成できてスケジュール一覧画面に移動する' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # プロジェクト一覧画面に1件登録があることを確認する
      visit projects_path
      expect(page).to have_content(@project.name)
      # スケジュール一覧画面へのボタンがあることを確認する
      expect(page).to have_content('スケジュール')
      # スケジュール一覧画面へ移動する
      click_link 'スケジュール'
      expect(current_path).to eq(schedules_path)
      # プロジェクトが1件以上作成されていることを確認する
      expect(Project.count).not_to eq 0
      # 作成するボタンをクリックし、作成画面に移動する
      click_link '作成する'
      expect(current_path).to eq(new_schedule_path)
      # フォームに情報を入力する
      select @project.name, from: 'schedule[project_id]'
      fill_in 'schedule[title]', with: @schedule.title
      fill_in 'schedule[start_date]', with: @schedule.start_date
      fill_in 'schedule[end_date]', with: @schedule.end_date
      select @schedule.work.name, from: 'schedule[work_id]'
      # 送信するとScheduleモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(1)
      # 一覧画面にリダイレクトされる
      expect(current_path).to eq(schedules_path)
      # 先程作成したスケジュールのタイトルが表示される
      expect(page).to have_content(@project.name + ' ＞ ' + @schedule.title)
      end
    end

    context '新規作成できないとき' do
      it 'プロジェクトが1件も作成されていない場合スケジュールを作成できない' do
        @user = FactoryBot.create(:user)
        @schedule = FactoryBot.build(:schedule)
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@user.id))
      # Projectモデルに1件も登録がないことを確認する
      expect(Project.count).to eq 0
      # スケジュール一覧画面へ移動する
      click_link 'スケジュール'
      expect(current_path).to eq(schedules_path)
      # 作成するボタンをクリックし、作成画面に移動する
      click_link '作成する'
      expect(current_path).to eq(new_schedule_path)
      # 作成画面に「まずはプロジェクトを作成しましょう！」のテキストがあることを確認する
      expect(page).to have_content('まずはプロジェクトを作成しましょう！')
      # 作成画面にフォームがないことを確認する
      expect(page).not_to have_selector('form')
      end

      it '登録されているプロジェクトがFIX後の場合、スケジュールを作成できない' do
        @project = FactoryBot.create(:project, project_start: Date.today - 3, project_end: Date.today - 1)
        @project_user = FactoryBot.create(:project_user, project_id: @project.id)
        @schedule = FactoryBot.build(:schedule, project_id: @project.id)
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # スケジュール作成画面へ移動する
      click_link 'スケジュール新規作成'
      expect(current_path).to eq(new_schedule_path)
      # FIX後のプロジェクトが選択肢にないことを確認する
      find('select[name="schedule[project_id]"]').click
      expect(page).not_to have_selector("option[value='#{@project.id}']")
      end

      it '入力する内容に誤りがある場合、スケジュールを作成できない' do
        @project = FactoryBot.create(:project, project_start: Date.today, project_end: Date.today + 1)
        @project_user = FactoryBot.create(:project_user, project_id: @project.id)
        @schedule = FactoryBot.build(:schedule, project_id: @project.id)
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # スケジュール作成画面へ移動する
      click_link 'スケジュール新規作成'
      expect(current_path).to eq(new_schedule_path)
      # フォームに情報を入力する
      select @project.name, from: 'schedule[project_id]'
      fill_in 'schedule[title]', with: @schedule.title
      fill_in 'schedule[start_date]', with: @schedule.start_date
      fill_in 'schedule[end_date]', with: @schedule.start_date - 1
      select @schedule.work.name, from: 'schedule[work_id]'
      # 送信してもScheduleモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(0)
      # 作成画面に戻されるされる
      expect(current_path).to eq(schedules_path)
      # 作成画面にエラーテキストが表示されていることを確認する
      expect(page).to have_content("End date must be greater than Project start")
      end
    end
  end

  describe 'schedule編集' do
    before do
      @project = FactoryBot.create(:project, project_start: Date.today, project_end: Date.today + 3)
      @project_user = FactoryBot.create(:project_user, project_id: @project.id)
      @schedule = FactoryBot.create(:schedule, project_id: @project.id)
    end

    context '編集できる場合' do
      it 'ログインしているユーザーは誰でも編集できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # スケジュール一覧画面に遷移し該当のスケジュールがあることを確認する
      visit schedules_path
      expect(page).to have_content(@project.name + ' ＞ ' + @schedule.title)
      # 該当のスケジュールをクリックし、詳細画面に遷移する
      all('.schedule_border')[0].click_link "#{@project.name} ＞ #{@schedule.title}"
      expect(current_path).to eq(schedule_path(@schedule.id))
      # 編集画面に遷移し、作成済みの内容を修正する
      click_link '編集'
      expect(current_path).to eq(edit_schedule_path(@schedule.id))
      fill_in 'schedule[title]', with: @schedule.title + '修正しました'
      # 送信してもScheduleモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(0)
      # 詳細画面に遷移することを確認する
      expect(current_path).to eq(schedule_path(@schedule.id))
      # 詳細画面に先程修正したスケジュールタイトルが表示されていることを確認する
      expect(page).to have_content(@schedule.title + '修正しました')
      end
    end

    context '編集できない場合' do
      it 'ログインしていないユーザーはスケジュールを編集できない' do
      # ルートパスに遷移する
      basic_pass root_path
      visit root_path
      # ログインせずにスケジュール編集画面にアクセスする
      visit edit_schedule_path(@schedule.id)
      # ログイン画面にリダイレクトすることを確認する
      expect(current_path).to eq(new_user_session_path)
      end
      it '編集内容に誤りがある場合、スケジュールを編集できない' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # スケジュール一覧画面に遷移し該当のスケジュールの詳細画面に遷移する
      visit schedules_path
      all('.schedule_border')[0].click_link "#{@project.name} ＞ #{@schedule.title}"
      expect(current_path).to eq(schedule_path(@schedule.id))
      # 編集画面に遷移し、作成済みの内容を修正する
      click_link '編集'
      expect(current_path).to eq(edit_schedule_path(@schedule.id))
      fill_in 'schedule[title]', with: ''
      # 送信してもScheduleモデルのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Schedule.count }.by(0)
      # 編集画面に戻されるされる
      expect(current_path).to eq(schedule_path(@schedule.id))
      end
    end
  end

  describe 'schedule削除' do
    before do
      @project = FactoryBot.create(:project, project_start: Date.today, project_end: Date.today + 3)
      @project_user = FactoryBot.create(:project_user, project_id: @project.id)
      @schedule = FactoryBot.create(:schedule, project_id: @project.id)
    end

    context '削除できる場合' do
      it 'ログインしているユーザーは誰でも削除できる' do
      # ログインする
      basic_pass root_path
      visit root_path
      fill_in 'user[email]', with: @project_user.user.email
      fill_in 'user[password]', with: @project_user.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(user_path(@project_user.user_id))
      # スケジュール一覧画面に遷移し該当のスケジュールの詳細画面に遷移する
      visit schedules_path
      all('.schedule_border')[0].click_link "#{@project.name} ＞ #{@schedule.title}"
      expect(current_path).to eq(schedule_path(@schedule.id))
      # 削除ボタンをクリックするとScheduleのカウントが1つ少なくなることを確認する
      expect{
        click_link '削除'
      }.to change { Schedule.count }.by(-1)
      # 一覧画面に遷移することを確認する
      expect(current_path).to eq(schedules_path)
      # 一覧画面に先程修正したスケジュールタイトルが表示されていることを確認する
      expect(page).not_to have_content("#{@project.name} ＞ #{@schedule.title}")
      end
    end

    context '削除できない場合' do
      it 'ログインしていないユーザーはスケジュールを削除できない' do
      # ルートパスに遷移する
      basic_pass root_path
      visit root_path
      # ログインせずにスケジュール削除リンクにアクセスしてもScheduleモデルのカウントが変わらないことを確認する
      expect{
        delete schedule_path(@schedule.id)
      }.to change { Schedule.count }.by(0)
      # ログイン画面にリダイレクトすることを確認する
      expect(current_path).to eq(root_path)
      end
    end
  end
end
