class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :setup_page

  private

  def page_title(string)
    @page[:title] = "#{string} - #{app_name}"
  end

  def setup_page
    @page = { title: app_name }
  end

  def app_name
    Rails.application.class.module_parent.name
  end
end
