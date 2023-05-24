class Alert < ApplicationRecord
  belongs_to :user

  validates :target_price, presence: true
  validates :status, presence: true

  def trigger!
    binding.pry
    UserMailer.with(user: self.user, alert: self).price_alert_email.deliver_now
    update(status: 'triggered')
  end
end
