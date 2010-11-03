class Picture < ActiveRecord::Base
  belongs_to :user
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  scope :public, where(:private => false)

  class << self
    def user(user_id)
      where("pictures.user_id = ?", user_id)
    end
  end

end
