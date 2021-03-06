class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  field :admin, :type => Boolean, :default => false
  field :bio
  
  references_many :pictures
  references_many :feedbacks

  attr_accessible :username, :email, :password, :password_confirmation
  
  class << self
    def find_by_username(username) 
      first(:conditions => {:username => username})
    end
  end

  def can_edit?(editable)
    editable && editable.user == self || self.admin?
  end
end
