class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validate :email_check

  after_create :send_welcome_email
  has_many :user_questions, dependent: :destroy
  has_many :questions, through: :user_questions
  

private

	def email_check
		if !email.match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/)
			errors.add(:email, "Please enter a valid email address.")
		end
	end

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver
  end

end