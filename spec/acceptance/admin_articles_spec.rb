require 'spec_helper'

feature "Articles administration interface" do

  background do
    admin = Factory(:admin)
    @email, @password = admin.email, admin.password
    @admin_user = TestUser.new(:email => @email, :password => @password)
  end

  scenario "admin can browse all articles" do
    alex = @admin_user
    alex.login # alex was already "registered" in factory as admin
    alex.roles :article_manager
    alex.open_articles_listing
    # TODO finish
  end


  scenario "admin removes an article"
  scenario "admin adds an article" do
    oor = { title:   'Objects On Rails spotlight',
            summary: 'Plain Ruby Objects everywhere!',
            content: 'Forget everything you knew before...' }

    js = { title:   'Javascript and Web 2.0',
           summary: 'How JS slowdown the web.',
           content: 'Sometimes JS become tooooo slooow' }

    alex = @admin_user
    alex.login
    alex.roles :article_manager

    alex.add_article oor
    alex.add_article js
  end
  scenario "admin provides more details on article"

end
