module ApplicationHelper
  def gravatar(email, size = 100)
    the_hash = Digest::MD5.hexdigest(email).to_s
    image_tag("http://www.gravatar.com/avatar/#{the_hash}?s=#{size}&d=mm", 
              {:alt => 'avatar', :class => 'avatar'})
  end
end

