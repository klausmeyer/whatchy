module ApplicationHelper
  def banner_url(show)
    "#{Rails.application.config.x.banner_cache_host}#{show.image}"
  end
end
