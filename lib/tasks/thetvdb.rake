namespace :thetvdb do
  desc "Synchronize all shows against TheTVDB"
  task sync_all_shows: :environment do
    Show.all.each do |show|
      attempt ||= 1
      puts "Synchronizing Show Ref #{show.thetvdb_ref} (#{show.title}) - attempt: #{attempt}"
      Shows::Import.new(ref: show.thetvdb_ref).call
    rescue SocketError, Tvdb2::RequestError => e
      attempt += 1
      retry if attempt <= 3
      puts "ERROR: #{e.inspect}"
      Airbrake.notify(e)
    rescue RuntimeError => e
      puts "ERROR: #{e.inspect}"
      Airbrake.notify(e)
    end
  end
end
