require 'spec_helper'

feature "Articles" do

  # FIXME Use factories for article creation
  scenario "reader can browse articles" do
    oor = { title:   'Objects On Rails spotlight',
            summary: 'Plain Ruby Objects everywhere!',
            content: 'Forget everything you knew before...' }

    js = { title:   'Javascript and Web 2.0',
           summary: 'How JS slowdown the web.',
           content: 'Sometimes JS become tooooo slooow' }

    alex = TestUser.new
    alex.roles :article_manager

    alex.add_article oor
    alex.add_article js

    alice = TestUser.new
    alice.roles(:article_reader)
    #alice.register_and_login

    alice.open_articles_listing
    alice.see!(oor.title, oor.summary)
    alice.see!(js.title, js.summary)
    alice.not_see!(oor.content)
    alice.not_see!(js.content)

    alice.click_on(oor.title)
    alice.see!(oor.title, oor.summary, oor.content)
  end
end
