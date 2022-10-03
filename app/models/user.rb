class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :project_users
  has_many :projects, through: :project_users

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :work

  VALID_PASS_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  
  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true }
    validates :work_id,  numericality: {other_than: 1 , message: "can't be blank"}
  end

  validates :password, format: { with: VALID_PASS_REGEX, message: "is invalid"}, unless: :project?
  validates :profile_text, {length: {maximum: 800}}

  def project?
    validation_context == :project
  end

end
