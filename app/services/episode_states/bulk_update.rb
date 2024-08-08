module EpisodeStates
  class BulkUpdate
    def initialize(parent:, user:, params:)
      self.parent = parent
      self.user   = user
      self.params = params
    end

    def call
      update_states
    end

    private

    attr_accessor :parent, :user, :params

    def update_states
      parent.episodes.each do |episode|
        episode.episode_states.find_or_initialize_by(user: user).tap do |state|
          state.seen_at = params[:seen].to_s == "true" ? Time.current : nil
          state.save!
        end
      end
    end
  end
end
