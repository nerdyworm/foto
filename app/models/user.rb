class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  embeds_one :profile
  # Setup accessible (or protected) attributes for your model
  #attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  #has_one :profile
  #has_many :pictures  
  #after_create :create_profile

  def can_edit?(editable)
    editable && editable.user_id == self.id || self.admin?
  end
end
