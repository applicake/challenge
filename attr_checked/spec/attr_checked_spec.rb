require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    eval("class Tester#{@solution.name}; end")
    klass = Object.const_get("Tester#{@solution.name}")
    klass.send :include, @solution.constant
    klass.send("#{@solution.name}_attr_checked", :age) { |v| v >= 18 }
    @instance = klass.new
  end
  
  spec "should work as a setter and a getter" do
    @instance.age = 20
    @instance.age.should == 20
  end

  spec "should not work as a setter when value is not valid" do
    lambda { @instance.age = 9 }.should raise_exception
    @instance.age.should_not == 9
  end
  
end
