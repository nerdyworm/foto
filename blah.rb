require 'mongoid'
require 'paperclip'

class Test
  include Mongoid::Document
  include Paperclip::ClassMethods

  field :avatar_file_name
  field :avatar_content_type
  field :avatar_file_size,    :type => Integer
  field :avatar_updated_at,   :type => DateTime

  
  has_attached_file :avatar,
    :path           => ":attachment/:id/:style/:basename.:extension",
    :storage        => :s3,
    :s3_credentials => File.join('asdf' 'config', 's3.yml'),
    :styles => {
      :original => ['1920x1680>', :jpg],
      :small    => ['100x100#', :jpg],
      :medium   => ['250x250', :jpg],
      :large    => ['500x500>', :jpg]
    },
    :convert_options => { :all => '-background white -flatten +matte'}

end
