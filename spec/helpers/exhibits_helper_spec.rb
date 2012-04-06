require_relative '../spec_helper_lite'
stub_class 'Exhibit'
require_relative '../../app/helpers/exhibits_helper'

describe ExhibitsHelper do
  before do
    @it = Object.new
    @it.extend ExhibitsHelper
    @context = stub.as_null_object
  end

  it "delegates exhibition decisions to Exhibit" do
    model = Object.new
    ::Exhibit.should_receive(:exhibit).with(model, @context)
    @it.exhibit(model, @context)
  end
end
