require "spec_helper_lite"
require_relative '../../lib/general_mapper'

describe GeneralMapper do
  subject { GeneralMapper.tap { |mapper| mapper.persistence = persistence } }
  let(:persistence) { mock(:persistence).tap { |m| m.stub_chain(:order, :limit) } }

  let(:model_instance) { stub.as_null_object }
  let(:model) { stub }
  before(:each) do
    model.stub(:new).and_return(model_instance)
  end

  it 'should delegate any unknown method to persistence' do
    persistence.should_receive(:unknown_method)
    subject.unknown_method
  end

  it "should wrap any number of chain method calls" do
    result = subject.order('date').limit(10)
    result.should be_instance_of GeneralMapper
  end

  it "should delegate chain methods to persistence" do
    relation = mock(:relation)
    relation.should_receive(:limit).with(10)
    persistence.should_receive(:order).with('date').and_return(relation)

    subject.order('date').limit(10)
  end

  describe "#to_a (to_ary)" do
    let(:records) { [stub(:record1)] }
    # let(:records) { [stub, stub, stub] }
    let(:enum) { stub(:enum).tap { |e| e.stub(:to_a).and_return(records) } }
    let(:persistence) { mock(:persistence).tap { |m| m.stub_chain(:order, :limit).and_return(enum) } }

    subject { GeneralMapper.order('date').limit(10) }

    before(:each) do
      GeneralMapper.model = model
      GeneralMapper.persistence = persistence
    end

    it "should return array" do
      subject.stub(:new_model)
      subject.to_a.should be_instance_of Array
    end

    it "should call load_attributes_from_persistence on element" do
      records.each { |record| model_instance.should_receive(:load_attributes_from).with(record).once }
      # records.each { |record| should_receive(:load_attributes_from_persistence).with(record).once }
      subject.to_a
    end
  end

  describe "#model_methods" do
    before(:each) do
      GeneralMapper.model_methods = []
    end

    it "should store methods" do
      GeneralMapper.model_methods = [:fetch_model]
      GeneralMapper.model_methods.should eq [:fetch_model]
    end

    it "should be able to add method by <<" do
      GeneralMapper.model_methods << :fetch_model << :find
      GeneralMapper.model_methods.should eq [:fetch_model, :find]
    end
  end

  describe "call model_method" do
    let(:persistence_instance) { stub }
    let(:persistence) { mock(:persistence).tap { |m| m.stub(:fetch_model).and_return(persistence_instance) } }

    before(:each) do
      GeneralMapper.model = model
      GeneralMapper.persistence = persistence
      GeneralMapper.model_methods = [:fetch_model]
    end

    context "on Mapper" do
      it "should return new model instance" do
        GeneralMapper.fetch_model.should eq model_instance
      end

      it "should return new model instance" do
        GeneralMapper.fetch_model.should eq model_instance
      end

      it "should load attributes to model from persistence object" do
        model_instance.should_receive(:load_attributes_from).with(persistence_instance);
        GeneralMapper.fetch_model
      end
    end

    context "on mapper instance" do
      it "should return new model instance" do
        persistence_instance.stub(:fetch_model).and_return(model_instance)
        GeneralMapper.new(persistence_instance).fetch_model.should eq model_instance
      end
    end
  end
end
