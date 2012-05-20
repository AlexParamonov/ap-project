require "spec_helper_lite"
require "ostruct"
require_relative '../../lib/persistence_mapper.rb'
require_relative '../../lib/general_mapper.rb'

# TODO split into 2 tests or wait for DataMapper 2 :)
describe PersistenceMapper do
  let (:blog_class) do
    cls = Class.new do
        attr_accessor :title, :content
        include PersistenceMapper

        def attributes
          { title: nil, content: nil }
        end

        class Mapper < GeneralMapper
        end
      end
    cls::Mapper.model = cls
    # TODO remove this
    cls::Mapper.model_methods = [:find]
    cls
  end

  it "should load attributes from persistence by id" do
    orm_object = OpenStruct.new(title: 'My awesome blog', content: 'Welcome!')
    orm_class = stub(:orm_class)
    orm_class.should_receive(:find).with(1).and_return(orm_object)

    blog_class::Mapper.persistence = orm_class

    blog = blog_class::Mapper.find(1)

    blog.should be_kind_of blog_class
    blog.title.should eq 'My awesome blog'
    blog.content.should eq 'Welcome!'
  end

  it "should set mapped ORM object to PORO" do
    orm_object = stub(:orm_object).as_null_object
    orm_class  = stub(:orm_class)
    orm_class.stub(:new).and_return(orm_object)
    orm_class.stub(:find).and_return(orm_object)

    blog_class::Mapper.persistence = orm_class

    blog = blog_class::Mapper.find(1)
    blog.persistence.should eq orm_object
  end

  describe "instance" do
    subject { blog_class.new }

    it "should load attributes from persistrence" do
      persistence = OpenStruct.new(title: 'My awesome blog', content: 'Welcome!')
      subject.persistence = persistence
      subject.load_attributes_from_persistence

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

      subject.persistence = persistence
      subject.load_attributes_to_persistence
    end

    it "should delegate #persisted? to persistence" do
      persistence = mock(:persistence)
      persistence.should_receive(:persisted?)
      subject.persistence = persistence

      subject.persisted?
    end
  end
end
