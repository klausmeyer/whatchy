require 'rails_helper'

RSpec.describe EpisodeStates::BulkUpdate do
  let(:instance) { described_class.new(parent: episodes.first.season, user: user, params: params) }

  let(:user)     { FactoryBot.create :user }
  let(:season)   { FactoryBot.create :season }
  let(:episodes) { FactoryBot.create_list :episode, 3, season: season }

  describe '#call' do
    shared_examples 'updating episode states' do
      let(:episodes_seen_at) { episodes.map { |e| e.episode_states.first.seen_at } }

      context 'with seen: true in params' do
        let(:params) do
          { seen: 'true' }
        end

        it 'sets the episodes to seen' do
          instance.call

          expect(episodes_seen_at).to all(be_present)
        end
      end

      context 'with seen: false in params' do
        let(:params) do
          { seen: 'false' }
        end

        it 'sets the episodes to unseen' do
          instance.call

          expect(episodes_seen_at).to all(be_nil)
        end
      end
    end

    context 'with episode states present' do
      before do
        episodes.each { |e| e.episode_states.create! user: user }
      end

      include_examples 'updating episode states'
    end

    context 'with no episode states' do
      include_examples 'updating episode states'
    end
  end
end
