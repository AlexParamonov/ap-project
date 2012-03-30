FactoryGirl.define do
  factory :dummy_article, :class => Article do
    factory :oor_article do
      title   'Objects On Rails spotlight'
      summary 'Plain Ruby Objects everywhere!'
      content 'Forget everything you knew before....'
    end

    factory :js_article do
      title   'Javascript and Web 2.0'
      summary 'How JS slowdown the web.'
      content 'Sometimes JS become tooooo slooow'
    end

    factory :invisible_article do
      title   'I am hidded'
      summary 'You should not see me!'
      content 'How you got here???!!!!'
    end
  end


  #
  ## This will use the User class (Admin would have been guessed)
  #factory :admin, :class => User do
  #  first_name 'Admin'
  #  last_name  'User'
  #  admin true
  #end
  #
  ## The same, but using a string instead of class constant
  #factory :admin, :class => 'user' do
  #  first_name 'Admin'
  #  last_name  'User'
  #  admin true
  #end
end
