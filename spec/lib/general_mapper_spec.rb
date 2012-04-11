require "spec_helper_lite"
require_relative '../../lib/general_mapper'

describe GeneralMapper do
  subject { GeneralMapper.tap { |mapper| mapper.persistence = persistence } }
  let(:persistence) { mock(:persistence).tap { |m| m.stub_chain(:order, :limit) } }

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
    let(:model) { Class.new }
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
      subject.stub(:on_eval)
      subject.to_a.should be_instance_of Array
    end

    it "should call load_attributes_from_persistence on element" do
      records.each { |record| model.any_instance.should_receive(:load_attributes_from).with(record).once }
      # records.each { |record| should_receive(:load_attributes_from_persistence).with(record).once }
      subject.to_a
    end
  end
end
