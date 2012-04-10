require "spec_helper_lite"
require "ostruct"
require_relative '../../lib/persistence_mapper.rb'

describe PersistenceMapper do
  let (:blog_class) do
    Class.new do
      attr_accessor :title, :content
      include PersistenceMapper

      def attributes
        { title: nil, content: nil }
      end
    end
  end

  it "should load attributes from persistence by id" do
    persistence = mock(:persistence)
    persistence.should_receive(:find).with(1).and_return(
      OpenStruct.new(title: 'My awesome blog', content: 'Welcome!')
    )

    blog = blog_class.load_from persistence, 1
    blog.should be_kind_of blog_class

    blog.title.should eq 'My awesome blog'
    blog.content.should eq 'Welcome!'
  end

  describe "instance" do
    subject { blog_class.new }

    it "should load attributes from persistrence" do
      persistence = OpenStruct.new(title: 'My awesome blog', content: 'Welcome!')
      subject.load_attributes_from persistence

      subject.title.should eq 'My awesome blog'
      subject.content.should eq 'Welcome!'
    end

    it "should load attributes to persistence" do
      subject.title = 'My awesome blog'
      subject.content = 'Welcome!'

      persistence = mock(:persistence)
      persistence.should_receive('title=').with('My awesome blog')
      persistence.should_receive('content=').with('Welcome!')
      persistence.should_receive('save!')

      subject.load_attributes_to persistence
    end
  end
end
