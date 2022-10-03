require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @project = FactoryBot.build(:project)
  end

  describe 'プロジェクトの新規作成' do
    context '新規作成できる場合' do
      it '全ての情報を適切に入力していれば作成できる' do
        expect(@project).to be_valid
      end
      it '詳細テキストがなくても作成できる' do
        @project.about = ''
        @project.valid?(:project)
        expect(@project).to be_valid
      end
      it '添付ファイルがなくても作成できる' do
        @project.files = nil
        @project.valid?(:project)
        expect(@project).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'nameが空の場合は作成できない' do
        @project.name = ''
        @project.valid?(:project)
        expect(@project.errors.full_messages).to include("Name can't be blank")
      end
      it 'project_startが未選択の場合は作成できない' do
        @project.project_start = ''
        @project.project_end = Faker::Date.between(from: 40.days.ago, to: Date.tomorrow)
        @project.valid?(:project)
        expect(@project.errors.full_messages).to include("Project start can't be blank")
      end
      it 'project_endが未選択の場合は作成できない' do
        @project.project_end = ''
        @project.valid?(:project)
        expect(@project.errors.full_messages).to include("Project end can't be blank")
      end
      it 'project_endがproject_startよりも前の日付の場合は作成できない' do
        @project.project_end = @project.project_start - 1
        @project.valid?(:project)
        expect(@project.errors.full_messages).to include("Project end must be greater than Project start")
      end
    end
  end
end
