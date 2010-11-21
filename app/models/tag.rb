class Tag
  include Mongoid::Document
  field :name, :type => String
  key   :name
  referenced_in :picture

  after_destroy :remove_references

  def to_s
    name
  end

  def remove_references
    Picture.remove_tag(name)
  end
end
