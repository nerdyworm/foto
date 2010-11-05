Factory.define :user do |f|
  #factory :user do
    f.sequence(:email) {|n| "person#{n}@example.com" }
    f.password "password"
    f.password_confirmation "password"
  #end

  # This will use the User class (Admin would have been guessed)
  #factory :admin, :class => User do
  #  first_name 'Admin'
  #  last_name  'User'
  #  admin true
  #end

  # The same, but using a string instead of class constant
  #factory :admin, :class => 'user' do
  #  first_name 'Admin'
  #  last_name  'User'
  #  admin true
  #end
end

Factory.define :picture do |f|
  f.name "picture name"
end

Factory.define :tag do |f|
  f.name "tag"
end
