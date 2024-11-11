require 'rails_helper'

RSpec.describe Episodes::UnseenQuery do
  let(:instance) { described_class.new(season) }

  let(:user)   { FactoryBot.create :user, :confirmed }
  let(:show)   { FactoryBot.create :show }
  let(:season) { FactoryBot.create :season, show: show }

  let!(:episodes) { FactoryBot.create_list :episode, 5, season: season }

  describe '#for_user' do
    let(:result) { instance.for_user(user) }

    shared_examples 'returning unseen episodes for parent' do
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

        context 'with episodes airing in future' do
          before do
            future_episodes.each { |e| e.update! first_aired: Date.today + 3.months }
          end

          let(:future_episodes) { episodes.take(3) }

          it 'returns only the seen episodes' do
            expect(result.count).to eq episodes.count - future_episodes.count
          end
        end
      end
    end

    context 'with a show as parent' do
      let(:parent) { show }

      include_examples 'returning unseen episodes for parent'
    end

    context 'with a season as parent' do
      let(:parent) { season }

      include_examples 'returning unseen episodes for parent'
    end
  end
end
