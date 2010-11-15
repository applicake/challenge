require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @money = klass.new
  end

  spec "change" do
    @money.change(5, [1, 2]).should =~ [2, 2, 1]
    @money.change(10, [2, 3, 4]).should =~ [4, 4, 2]
    @money.change(15, [4, 2, 1]).should =~ [4, 4, 4, 2, 1]
    @money.change(25, [10, 5]).should =~ [10, 10, 5]
    @money.change(9, [3, 2, 1]).should =~ [3, 3, 3]
    @money.change(9, [2]).should == []
    @money.change(10, []).should == []
    @money.change(10, [20]).should == []
    @money.change(5, [3,4]).should == []
  end
  
end

