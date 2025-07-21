require 'rails_helper'

RSpec.describe Shows::UnseenQuery do
  let(:instance) { described_class.new }

  describe '#for_user' do
    let(:result) { instance.for_user(user) }

    let(:user) { FactoryBot.create :user, :confirmed }

    let(:show_seen)            { FactoryBot.create :show }
    let(:show_partly_seen)     { FactoryBot.create :show }
    let(:show_unseen)          { FactoryBot.create :show }
    let(:season_seen)          { FactoryBot.create :season, show: show_seen }
    let(:season_partly_seen)   { FactoryBot.create :season, show: show_partly_seen }
    let(:season_unseen)        { FactoryBot.create :season, show: show_unseen }
    let(:episodes_seen)        { FactoryBot.create_list :episode, 3, season: season_seen }
    let(:episodes_partly_seen) { FactoryBot.create_list :episode, 3, season: season_partly_seen }
    let(:episodes_unseen)      { FactoryBot.create_list :episode, 3, season: season_unseen }

    before do
      FactoryBot.create :subscription, user: user, show: show_seen
      FactoryBot.create :subscription, user: user, show: show_partly_seen
      FactoryBot.create :subscription, user: user, show: show_unseen

      episodes_seen.each do |episode|
        FactoryBot.create :episode_state, :seen, episode: episode, user: user
      end

      episodes_partly_seen.each_with_index do |episode, index|
        trait = index == 2 ? :unseen : :seen
        FactoryBot.create :episode_state, trait, episode: episode, user: user
      end

      episodes_unseen
    end

    it 'returns shows with unseen episodes' do
      expect(result.pluck(:id)).to eq [ show_partly_seen.id, show_unseen.id ]
    end
  end
end
