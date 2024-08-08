namespace :crons do
  desc "Daily Cronjobs"
  task daily: :environment do
    %w[thetvdb:sync_all_shows].each do |name|
      puts "Running rake task #{name}"
      Rake::Task[name].invoke
    end
  end
end
