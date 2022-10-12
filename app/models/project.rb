class Project < ApplicationRecord
  has_many_attached :files
  has_many :project_users, dependent: :destroy
  has_many :users, through: :project_users
  has_many :schedules, dependent: :destroy
  has_many :comments, dependent: :destroy

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

  scope :with_keywords, -> keywords {
    if keywords.present?
      squished_keywords = keywords.squish
      keywords = squished_keywords.split(" ")
      name = Project.arel_table[:name]
      about = Project.arel_table[:about]
      where(keywords.map {|keyword|
        name.matches("%#{keyword}%").or( about.matches("%#{keyword}%") )
      }.inject(:and))
    end
  }

  include FlagShihTzu

  has_flags(
    1 => :member_wanted,
    :column => 'member_flag'
  )
end
