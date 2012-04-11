class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles, force: true do |t|
      t.integer :id
      t.string :title
      t.string :summary
      t.text :content
      t.datetime :pubdate

      t.timestamps
    end
  end
end

