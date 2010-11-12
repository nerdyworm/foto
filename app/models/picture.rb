class Picture 
  include Mongoid::Document
  include Paperclip
  
  field :name
  field :tags, :type => Array
  field :private, :type => Boolean
  
  field :avatar_file_name
  field :avatar_content_type
  field :avatar_file_size,    :type => Integer
  field :avatar_updated_at,   :type => DateTime

  
  has_attached_file :avatar,
    :path           => ":attachment/:id/:style/:basename.:extension",
    :storage        => :s3,
    :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    :styles => {
      :original => ['1920x1680>', :jpg],
      :small    => ['100x100#', :jpg],
      :medium   => ['250x250', :jpg],
      :large    => ['500x500>', :jpg]
    },
    :convert_options => { :all => '-background white -flatten +matte'}
  
  
  
  #belongs_to :user
  #has_many :comments
  #has_and_belongs_to_many :tags
  #has_attached_file :pic, 
  #  :storage => :s3, 
  #  :s3_credentials => "#{Rails.root}/config/s3.yml", 
  #  :path => ":attachment/:id/:style.:extension",
  #  :styles => { :full => "730x730>", :medium => "350x220#", :thumb => "100x100>" }

  #scope :public, where(:private => false)
  #scope :ordered, order("pictures.created_at desc")

  #delegate :username, :to => :user

  class << self
    def user(user_id)
      where("pictures.user_id = ?", user_id)
    end

    def paginate(page)
      limit(6).offset(page ? page.to_i * 6 : 0)
    end
  end

  def tags_s
    #tags.map(&:name).join(", ")
  end

  def tags_s=(ts)
    self.tags = []
    ts.split(",").each do |tag|
      self.tags << Tag.find_or_create_by_name(tag.downcase.strip)
    end
  end

end
