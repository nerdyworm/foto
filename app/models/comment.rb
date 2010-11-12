class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :comment
  
  field :email
  field :username
  
  embedded_in :picture, :inverse_of => :comments
end
