class Picture < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :tags
  has_attached_file :pic, :styles => { :full => "730x730>", :medium => "350x220#", :thumb => "100x100>" }

  scope :public, where(:private => false)
  scope :ordered, order("pictures.created_at desc")

  class << self
    def user(user_id)
      where("pictures.user_id = ?", user_id)
    end

    def paginate(page)
      limit(6).offset(page ? page.to_i * 6 : 0)
    end
  end

  def tags_s
    tags.map(&:name).join(", ")
  end

  def tags_s=(ts)
    self.tags = []
    ts.split(",").each do |tag|
      self.tags << Tag.find_or_create_by_name(tag.downcase.strip)
    end
  end

end
