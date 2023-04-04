require 'rails_helper'

RSpec.describe UserParty, type: :model do
  it { should belong_to :user }
  it { should belong_to :party }

  describe '#class_methods' do
    describe '#other_users' do
      it 'returns the other users and not the host user' do
        steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
        bob = User.create!(name: "bob", email: "bob@bob.com", password: "password")
        Party.create!(movie_id: 238, host_id: steve.id, duration: 175, date: "03/25/2023", time: "02:00 PM")
        expect(UserParty.other_users(steve.id)).to eq([bob])
        expect(UserParty.other_users(steve.id)).to_not include([steve])
      end
    end

    describe '#party_guests' do
      it 'creates a user party for each guest' do
        steve = User.create!(name: "steve", email: "steve@steve.com", password: "password")
        bob = User.create!(name: "bob", email: "bob@bob.com", password: "password")
        sheryl = User.create!(name: "sheryl", email: "sheryl@sheryl.com", password: "password")
        party = Party.create!(movie_id: 238, host_id: steve.id, duration: 175, date: "03/25/2023", time: "02:00 PM")
        
        expect(UserParty.party_guests([bob.id], party.id)).to eq([UserParty.last])
        expect(UserParty.party_guests([bob.id], party.id)).to_not include([sheryl])
        expect(UserParty.party_guests([bob.id, sheryl.id], party.id)).to eq(UserParty.last(2))
      end
    end
  end
end