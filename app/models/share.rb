class Share < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  has_many_attached :memo_files

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :hour

  with_options presence: true do
    validates :share_date
    validates :hour_id, numericality: {other_than: 1 , message: "can't be blank"}
  end
end
