HealthCheck.setup do |config|
  config.uri             = "health"
  config.standard_checks = []
  config.full_checks     = ["database", "migrations", "postgres_write"]

  config.add_custom_check("postgres_write") do
    readonly = ActiveRecord::Base.connection.execute("SELECT pg_is_in_recovery() AS readonly").first.fetch("readonly", false)
    readonly ? "Database is in read-only mode" : ""
  end
end
