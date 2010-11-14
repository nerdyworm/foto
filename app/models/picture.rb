class Picture
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :desc
  field :name
  field :username
  field :tags,    :type => Array
  field :private, :type => Boolean, :default => false
  
  mount_uploader :pic, PictureImageProcessor  
 
  embeds_many :comments
  
  referenced_in :user
  
  
  validates_presence_of :name
  validates_presence_of :username

  def user=(u)
    self.user_id  = u.id
    self.username = u.username
  end

  class << self
    def public 
      where(:private => false)
    end
    
    def ordered
      desc(:created_at)
    end
    
    def by_page(page)
      limit(6).skip(page ? page.to_i * 6 : 0)
    end
    
    def find_by_user_id(user_id)
      where(:user_id => user_id)
    end
  end

  def tags_s 
    self.tags.join(", ") if self.tags
  end

  def tags_s=(ts)
    self.tags = []
    ts.split(",").each do |tag|
      tag = tag.downcase.strip
      self.tags << tag unless self.tags.include? tag
    end
  end

end
