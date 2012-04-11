require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/enumerable_exhibit'

describe EnumerableExhibit do
  describe "class" do
    subject { EnumerableExhibit }

    it "is applicable to Enumerables" do
      subject.should be_applicable_to([])
      subject.should be_applicable_to({})
    end

    it "is inapplicable to singular objects" do
      subject.should_not be_applicable_to(Object.new)
    end

    it "is itself enumerable" do
      (subject < Enumerable).should be_true
    end
  end

  subject { EnumerableExhibit.new(model, context) }
  let(:model) { ["e1", "e2", "e3"] }
  let(:context) { Object.new }

  before(:each) do
    # #exhibit is part of the superclass interface, not this class'
    # interface, so it is fair game for stubbing
    subject.instance_eval do
      def exhibit(model)
        @last_exhibited = model
        "exhibit(#{model})"
      end
    end
  end

  describe "#each" do
    it "exhibits each element" do
      results = []
      subject.each do |e| results << e end
      results.should eq ["exhibit(e1)", "exhibit(e2)", "exhibit(e3)"]
    end
  end

  describe "#each_with_index" do
    it "exhibits each element" do
      results = []
      subject.each_with_index do |*e| results << e end
      results.should eq [ ["exhibit(e1)", 0],
                          ["exhibit(e2)", 1],
                          ["exhibit(e3)", 2] ]
    end
  end

  describe "#to_enum" do
    it "returns an exhibited enumerator" do
      subject.to_enum
      subject.instance_variable_get("@last_exhibited").to_a.should eq model
    end
  end

  describe "#to_ary" do
    it "returns itself" do
      subject.should eq subject.to_ary
    end
  end

  describe "#grep" do
    it "exhibits the result set" do
      subject.grep(/[12]/).should eq 'exhibit(["e1", "e2"])'
    end
  end

  describe "#select" do
    it "exhibits each result" do
      subject.select{|e| /[23]/ === e}.should eq 'exhibit(["e2", "e3"])'
    end
  end

  describe "#detect" do
    it "exhibits the result" do
      subject.detect{|e| /[23]/ === e}.should eq "exhibit(e2)"
    end
  end

  describe "#[]" do
    it "exhibits the result" do
      subject[1].should eq "exhibit(e2)"
    end
  end

  describe "#fetch" do
    it "exhibits the result" do
      subject.fetch(1).should eq "exhibit(e2)"
    end
  end

  describe "#first" do
    it "exhibits the result" do
      subject.first.should eq "exhibit(e1)"
    end
  end

  describe "#last" do
    it "exhibits the result" do
      subject.last.should eq "exhibit(e3)"
    end
  end

  describe "#min" do
    it "exhibits the result" do
      subject.min.should eq "exhibit(e1)"
    end
  end

  describe "#max" do
    it "exhibits the result" do
      subject.max.should eq "exhibit(e3)"
    end
  end

  describe "#minmax" do
    it "exhibits the result" do
      subject.minmax.should eq ["exhibit(e1)", "exhibit(e3)"]
    end
  end

  describe "#sort" do
    it "exhibits the result" do
      subject.sort{|x,y| y <=> x}.should eq 'exhibit(["e3", "e2", "e1"])'
    end
  end

  describe "#sort_by" do
    it "exhibits the result" do
      subject.sort_by(&:to_s).should eq 'exhibit(["e1", "e2", "e3"])'
    end
    it "returns an enumerator without arguments" do
      subject.sort_by.should =~ /Enumerator/
    end
  end

  describe "#reverse" do
    it "exhibits the result" do
      subject.reverse.should eq 'exhibit(["e3", "e2", "e1"])'
    end
  end

  describe "#slice" do
    it "exhibits the result" do
      subject.slice(1,2).should eq 'exhibit(["e2", "e3"])'
    end
  end

  describe "#values_at" do
    it "exhibits the result" do
      subject.values_at(0,2).should eq 'exhibit(["e1", "e3"])'
    end
  end

  describe "#reject" do
    it "exhibits the result" do
      subject.reject{|e| e =~ /2/}.should eq 'exhibit(["e1", "e3"])'
    end
    it "returns an enumerator without arguments" do
      subject.reject.should =~ /Enumerator/
    end
  end

  describe "#partition" do
    it "exhibits the result" do
      subject.partition{|e| e < "e2"}.
        should eq ['exhibit(["e1"])', 'exhibit(["e2", "e3"])']
    end
  end

  describe "#group_by" do
    it "exhibits the result" do
      subject.group_by{|e| e == "e2"}.
        should eq ({ true  => 'exhibit(["e2"])',
                     false => 'exhibit(["e1", "e3"])'})
    end
  end

  describe "#render" do
    let(:template) { Object.new }

    before do
      subject.instance_eval do
        def exhibit(model)
          model
        end
      end
      model.each do |e|
        e.instance_eval do
          def render(*)
            "R(#{self})"
          end
        end
      end
    end
    it "concatenates the rendered elements" do
      subject.render(template).should eq "R(e1)R(e2)R(e3)"
    end
    it "produces a safe string" do
      subject.render(template).should be_html_safe
    end
  end

end
