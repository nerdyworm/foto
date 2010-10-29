class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :username
end
