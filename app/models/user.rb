class User < ActiveRecord::Base
  has_secure_password
  has_many :task_users
  has_many :tasks, through: :task_users, dependent: :destroy
  has_many :oauth_users
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true
  validates :email, :presence => true, :format => { :with => EMAIL_REGEX }, :uniqueness => { :case_sensitive => false }
  validates :password, presence: true
  before_save do
    self.email.downcase!
  end
end
