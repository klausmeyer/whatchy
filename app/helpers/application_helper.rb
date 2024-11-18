module ApplicationHelper
  def flash_css_class(type)
    {
      "notice" => "info",
      "alert"  => "warning",
      "error"  => "danger"
    }.fetch(type, "primary")
  end

  def cover_url(path)
    if path.present?
      "#{Rails.application.config.x.banner_cache_host}#{path}"
    else
      image_url "cover-placeholder.png"
    end
  end

  def navigation_item(text, link)
    content_tag :li, class: [ "nav-item", request.original_fullpath == link ? "active" : nil ] do
      link_to text, link, class: "nav-link"
    end
  end

  def seen_at_label(episode)
    if episode.seen_at.present?
      text  = "Seen"
      title = localize(episode.seen_at)
    else
      text  = "Not seen"
      title = nil
    end

    content_tag :label, text, title: title, class: "custom-control-label", for: dom_id(episode, :seen)
  end

  def show_image_url(show, thumb:)
    return cover_url(show.image_url) unless show.image.attached?

    url_for(thumb ? show.image.variant(:thumb) : show.image)
  end
end
