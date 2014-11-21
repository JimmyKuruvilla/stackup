class User < ActiveRecord::Base
  validates_uniqueness_of :email
  after_create :send_welcome_email
  has_many :user_questions, dependent: :destroy
  has_many :questions, through: :user_questions
  

private

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver
  end


end
