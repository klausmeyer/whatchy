module ApplicationHelper
  def cover_url(path)
    if path.present?
      "#{Rails.application.config.x.banner_cache_host}#{path}"
    else
      image_url "cover-placeholder.png"
    end
  end

  def navigation_item(text, link)
    content_tag :li, class: ["nav-item", request.original_fullpath == link ? "active" : nil] do
      link_to text, link, class: "nav-link"
    end
  end
end
