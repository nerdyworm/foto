class Picture < ActiveRecord::Base
  has_attached_file :pic, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end