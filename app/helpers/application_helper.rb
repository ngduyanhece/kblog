module ApplicationHelper
  #Returns the full title on the per-page basics.
  def full_page(page_title = "")
    base_title = "Keblog"
    return base_title if page_title.empty?
    page_title + " | " + base_title
  end
end
