require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @weird_numbers = klass.new
  end
  
  spec "None for less then 50" do
    @weird_numbers.fetch_less_then(50).should == []
  end

  spec "One for less then 100" do
    @weird_numbers.fetch_less_then(100).should == [70]
  end
  
  spec "Two for less then 1000" do
    @weird_numbers.fetch_less_then(1000).should == [70, 836]
  end
    
end
