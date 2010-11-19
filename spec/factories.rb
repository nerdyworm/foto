Factory.define :user do |f|
  f.sequence(:email)    {|n| "person#{n}@example.com" }
  f.sequence(:username) {|n| "person#{n}" }
  f.password "password"
  f.password_confirmation "password"
end

Factory.define :picture do |f|
  f.name      "name"
  f.username  "username"
  f.pic       File.new("#{Rails.root}/public/images/rails.png")
  f.desc      "description"
end

Factory.define :feedback do |f|  
  f.email     "email@email.com"
  f.comment   "This is a comment"
  f.username  "username"
end
