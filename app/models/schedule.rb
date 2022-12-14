class Schedule < ApplicationRecord
  belongs_to :project
  has_many :shares, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :start_date
    validates :end_date
    validates :work_id, numericality: {other_than: 1 , message: "can't be blank"}
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :work

  validate :start_end_check

  def start_end_check
    if start_date.present? && end_date.present?
      errors.add(:end_date, "must be greater than Project start") unless
        self.start_date <= self.end_date
      end
    end
  # end

  scope :with_keywords, -> keywords {
    if keywords.present?
      squished_keywords = keywords.squish
      keywords = squished_keywords.split(" ")
      sch = Schedule.arel_table[:title]
      pro = Project.arel_table[:name]
      where(keywords.map {|keyword|
         sch.matches("%#{keyword}%").or( pro.matches("%#{keyword}%") )
      }.inject(:and))
    end
  }

end