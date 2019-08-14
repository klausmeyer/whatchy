require 'rails_helper'

RSpec.describe Seasons::UnseenEpisodesQuery do
  let(:instance) { described_class.new(season) }

  let(:user)   { FactoryBot.create :user }
  let(:season) { FactoryBot.create :season }

  let!(:episodes) { FactoryBot.create_list :episode, 5, season: season }

  describe '#for_user' do
    let(:result) { instance.for_user(user) }

    context 'with no episode states for the user' do
      it 'returns all episodes' do
        expect(result.count).to eq episodes.count
      end
    end

    context 'with episode states for the user' do
      context 'with all episodes seen' do
        before do
          episodes.each { |e| e.episode_states.create! user: user, seen_at: Time.now }
        end

        it 'returns no records' do
          expect(result.count).to eq 0
        end
      end

      context 'with all episodes unseen' do
        before do
          episodes.each { |e| e.episode_states.create! user: user, seen_at: nil }
        end

        it 'returns all episodes' do
          expect(result.count).to eq episodes.count
        end
      end

      context 'with a few episodes seen' do
        before do
          seen_episodes.each { |e| e.episode_states.create! user: user, seen_at: Time.now }
        end

        let(:seen_episodes) { episodes.take(3) }

        it 'returns only the seen episodes' do
          expect(result.count).to eq episodes.count - seen_episodes.count
        end
      end
    end
  end
end
