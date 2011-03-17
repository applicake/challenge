require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do
  before do
    @klass = @solution.constant
  end

  spec "Visiting tree with one node" do 
    ruby_tree = @klass.new( "Tomasz")
    ruby_tree.trip.should == ["Tomasz"]
  end
 
  spec "Visiting tree with three nodes" do 
    ruby_tree = @klass.new( "Tomasz", [@klass.new("Kasia"), @klass.new("Bartek")] )
    ruby_tree.trip.should == ["Tomasz", "Kasia", "Bartek"]
  end

  spec "Visiting tree with five nodes" do 
    ruby_tree = @klass.new( "Tomasz", [@klass.new("Kasia", [@klass.new("Agata"), @klass.new("Weronika")]), @klass.new("Bartek")] )
    ruby_tree.trip.should == ["Tomasz", "Kasia", "Agata", "Weronika", "Bartek"]
  end
end
