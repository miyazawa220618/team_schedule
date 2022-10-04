class Share < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  has_many_attached :memo_file

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :time

  with_options presence: true do
    validates :share_date
    validates :time_id, numericality: {other_than: 1 , message: "can't be blank"}
  end
end
