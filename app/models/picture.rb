class Picture
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :desc
  field :name
  field :username
  field :tags,    :type => Array
  field :private, :type => Boolean, :default => false
 
  field :voters,  :type => Array
  field :votes,   :type => Integer, :default => 0

  mount_uploader :pic, PictureImageProcessor  
 
  #embeds_many :comments
  references_many :feedbacks

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
   
    def vote(story_id, user_id, direction)
      story_id = BSON::ObjectId(story_id) if story_id.class == String
      user_id  = BSON::ObjectId(user_id) if user_id == String

      collection.update({'_id' => story_id, 'voters' => {'$ne' => user_id}}, 
        {'$inc' => {'votes' => direction}, '$push' => {'voters' => user_id}})
    end

    def downvote(story_id, user_id)
      self.vote(story_id, user_id, -1)
    end

    def upvote(story_id, user_id)
      self.vote(story_id, user_id, 1)
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
