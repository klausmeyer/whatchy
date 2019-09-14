namespace :thetvdb do
  desc "Synchronize all shows against TheTVDB"
  task sync_all_shows: :environment do
    Show.all.each do |show|
      puts "Synchronizing Show Ref #{show.thetvdb_ref} (#{show.title})"
      Shows::Import.new(ref: show.thetvdb_ref).call
    rescue => e
      puts e.inspect
    end
  end
end
