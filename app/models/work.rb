class Work < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ディレクター' },
    { id: 3, name: 'デザイナー' },
    { id: 4, name: 'エンジニア' }
  ]

  include ActiveHash::Associations
  has_many :users
  has_many :schedules
end