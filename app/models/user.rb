class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :orders

  validates_presence_of :name, :username, :password_digest
  validates_length_of :password, minimum: 6, maximum: 20, on: :create
end
