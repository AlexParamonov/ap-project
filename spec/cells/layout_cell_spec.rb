require 'spec_helper'

describe LayoutCell do
  context "cell rendering" do

    # context "rendering header" do
    #   subject { render_cell(:layout, :header) }

    #   it { should have_selector("h1", :content => "Layout#header") }
    #   it { should have_selector("p", :content => "Find me in app/cells/layout/header.html") }
    # end

  end


  context "cell instance" do
    subject { cell(:layout) }

    it { should respond_to(:header) }

  end
end
