module ApplicationHelper
  include Pagy::Frontend

  def head_page_title
    _set_title = content_for(:title)
    _set_title.present? ? "#{_set_title} || Sprint Zero" : "Sprint Zero"
  end

  def user_settings_sidebar(**args)
    render "shared/user_settings_sidebar", **args
  end
end
