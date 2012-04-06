require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/exhibit'

describe Exhibit do
  subject             { exhibit_class.new(model, context) }
  let(:exhibit_class) { Class.new(Exhibit) }
  let(:model)         { Object.new }
  let(:context)       { Object.new }

  describe '.exhibit_query' do
    it 'wraps the given methods so that their results are exhibited' do
      foo_result    = Object.new
      bar_result    = Object.new
      exhibited_foo = Object.new
      exhibited_bar = Object.new
      exhibit_class.module_eval do
        exhibit_query :foo, :bar
      end

      model.stub(:foo).and_return(foo_result)
      Exhibit.stub(:exhibit).with(foo_result, context).and_return(exhibited_foo)
      subject.foo.should eql exhibited_foo

      model.stub(:bar).with(123,456).and_return(bar_result)
      Exhibit.stub(:exhibit).with(bar_result, context).and_return(exhibited_bar)
      subject.bar(123,456).should eql exhibited_bar
    end
  end

  describe '#exhibit' do
    it 'calls Exhibt.exhibit with current context and model' do
      result      = Object.new
      other_model = Object.new
      Exhibit.stub(:exhibit).with(other_model, context).and_return(result)
      subject.exhibit(other_model).should eql result
    end
  end

  describe '#to_partial_path' do
    it 'delegates to the model if it has the method' do
      model.stub(:to_partial_path).and_return("MODEL_PARTIAL_PATH")
      subject.to_partial_path.should eq "MODEL_PARTIAL_PATH"
    end

    it 'uses munged model class name if it cannot delegate' do
      my_class = Object.new
      my_class.stub(:name).and_return("MyModule::MyClass")
      model.stub(:class).and_return(my_class)
      subject.to_partial_path.should eq '/my_module/my_classes/my_class'
    end
  end
end
