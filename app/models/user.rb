class User < ApplicationRecord
  has_many :alerts

  def to_h
    attributes.symbolize_keys.except(:password_digest)
  end

  def authenticate(password)
    return true if password_digest == password.to_s

    false
  end
end
