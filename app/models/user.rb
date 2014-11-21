class User < ActiveRecord::Base
  validates_uniqueness_of :email
  after_create :send_welcome_email

private

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver
  end


end
