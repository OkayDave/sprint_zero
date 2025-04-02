module ApplicationHelper
  def head_page_title
    _set_title = content_for(:title)
    _set_title.present? ? "#{_set_title} || Sprint Zero" : "Sprint Zero"
  end
end
