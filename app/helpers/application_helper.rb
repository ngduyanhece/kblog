module ApplicationHelper
  #Returns the full title on the per-page basics.
  def full_title(page_title = "")
    base_title = "Keblog"
    return base_title if page_title.empty?
    page_title + " | " + base_title
  end
  #return the gravatar for a specific email 
  def gravatar_for (user, options = {size: 80})
    size = options[:size]
  	email = user.email.downcase 
  	id = Digest::MD5::hexdigest(email)
  	url = "https://secure.gravatar.com/avatar/#{id}?s=#{size}"
  	image_tag url, alt: user.name, class: "gravatar"
  end
end
