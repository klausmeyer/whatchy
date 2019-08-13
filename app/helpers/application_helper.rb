module ApplicationHelper
  def banner_url(path)
    "#{Rails.application.config.x.banner_cache_host}#{path}"
  end
end
