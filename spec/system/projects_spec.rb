require 'rails_helper'

RSpec.describe "Projects", type: :system do
  before do
    @project = FactoryBot.build(:project)
  end

  context 'プロジェクトが新規作成できるとき' do
    it 'ログインしたユーザーは、新規作成できてプロジェクト一覧画面に移動する' do
      # ログインする
      # プロジェクト一覧画面へのボタンがあることを確認する
      # プロジェクト一覧画面へ移動する
      # プロジェクト新規作成ボタンがあることを確認する
      # 新規作成ページへ移動する
      # フォームに情報を入力する
      # 送信するとProjectモデルのカウントが1上がることを確認する
      # プロジェクト一覧画面へ遷移することを確認する
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（プロジェクト名）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（開始日）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（FIX予定日）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（メンバー画像）
    end
    it 'ログインしたユーザーは、新規作成できてプロジェクト一覧画面に移動する' do
      # ログインする
      # プロジェクト一覧画面へのボタンがあることを確認する
      # プロジェクト一覧画面へ移動する
      # プロジェクト新規作成ボタンがあることを確認する
      # 新規作成ページへ移動する
      # フォームに情報を入力する
      # 送信するとProjectモデルのカウントが1上がることを確認する
      # プロジェクト一覧画面へ遷移することを確認する
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（プロジェクト名）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（開始日）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（FIX予定日）
      # 一覧画面に先ほど作成した内容のプロジェクトが存在することを確認する（メンバー画像）
    end
  end

  context 'プロジェクトが新規作成できないとき' do
    
  end
end
