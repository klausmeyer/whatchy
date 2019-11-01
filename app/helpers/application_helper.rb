module ApplicationHelper
  def banner_url(path)
    "#{Rails.application.config.x.banner_cache_host}#{path}"
  end

  def navigation_item(text, link)
    content_tag :li, class: ["nav-item", request.original_fullpath == link ? "active" : nil] do
      link_to text, link, class: "nav-link"
    end
  end
end
