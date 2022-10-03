class Project < ApplicationRecord
  has_many_attached :files
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users

  with_options presence: true, if: -> { validation_context == :project} do
    validates :name
    validates :project_start
    validates :project_end
    validates :member_flag
  end

  validate :start_end_check, on: :project

  def start_end_check
    if project_start.present? && project_end.present?
      errors.add(:project_end, "must be greater than Project start") unless
        self.project_start <= self.project_end
    end 
  end


  include FlagShihTzu

  has_flags(
    1 => :member_wanted,
    :column => 'member_flag'
  )
end
