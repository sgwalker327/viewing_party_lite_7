class UserParty < ApplicationRecord
  belongs_to :user
  belongs_to :party

  enum role: %w(guest host)

  def self.other_users(id)
    User.where('id != ?', id)
  end

  def self.party_guests(users, party_id)
    users.map do |user_id|
      UserParty.create(user_id: user_id, party_id: party_id)
    end
  end
end