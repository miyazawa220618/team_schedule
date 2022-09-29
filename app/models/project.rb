class Project < ApplicationRecord
  has_many_attached :file
  has_many :project_users
  has_many :users, through: :project_users

  with_options presence: true do
    validates :name
    validates :project_start
    validates :project_end, comparison: { greater_than: :project_start }
    validates :member_flag
  end

  include FlagShihTzu

  has_flags(
    1 => :member_wanted
  )
end
