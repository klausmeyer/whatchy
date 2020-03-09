require 'rails_helper'

RSpec.describe Episodes::WithStatesQuery do
  let(:instance) { described_class.new(season.episodes) }

  describe '#for_user' do
    let(:result) { instance.for_user(alice) }

    let(:alice) { FactoryBot.create :user, email: 'alice@example.com' }
    let(:bob)   { FactoryBot.create :user, email: 'bob@example.com' }

    let!(:episode1) { FactoryBot.create :episode, season: season }
    let!(:episode2) { FactoryBot.create :episode, season: season }
    let!(:episode3) { FactoryBot.create :episode, season: season }

    let(:season) { FactoryBot.create :season }

    before do
      FactoryBot.create :episode_state, :seen, episode: episode1, user: alice
      FactoryBot.create :episode_state, :seen, episode: episode2, user: bob
    end

    it 'returns episodes with seen_at attribute based on the user' do
      expect(result.size).to eq 3

      episode = result.first
      expect(episode).to eq episode1
      expect(episode.seen_at).to be_a Time

      episode = result.second
      expect(episode).to eq episode2
      expect(episode.seen_at).to be_nil

      episode = result.third
      expect(episode).to eq episode3
      expect(episode.seen_at).to be_nil
    end
  end
end
