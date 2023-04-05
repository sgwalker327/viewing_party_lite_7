class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email

  validates_confirmation_of :password

  has_secure_password

  enum role: %w(default admin)


  # def hosted_parties(user_id)
  # Party.where(':host_id = ?', user_id)
  # end
  
  # def invited_parties
  #   Party.all.users.where("")
  # end
end