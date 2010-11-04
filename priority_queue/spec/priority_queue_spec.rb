require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @queue = klass.new
  end
  
  spec "should raise errors for empty queue " do
    @queue.min.should be_nil
    @queue.pop.should be_nil
  end  
  
  spec "should push, min and pop" do
    @queue.push("aaa", 10)
    @queue.push("bbb", 30)
    @queue.push("ccc", 20)
    @queue.min.should == "aaa"
    @queue.pop.should == "aaa"
    @queue.min.should == "ccc"
    @queue.pop.should == "ccc"
    @queue.min.should == "bbb"
    @queue.pop.should == "bbb"
  end
  
  spec "should not allow duplicate objects" do
    @queue.push("aaa", 10)
    lambda { @queue.push("aaa", 20) }.should raise_error
  end
  
  spec "should allow duplicate keys" do 
    @queue.push("aaa", 10)
    @queue.push("bbb", 10)
    obj1 = @queue.pop
    obj2 = @queue.pop
    ["aaa", "bbb"].should include(obj1)
    (["aaa", "bbb"] - [obj1]).should include(obj2)
  end
  
  spec "should decrease key" do
    @queue.push("aaa", 10)
    @queue.push("bbb", 30)
    @queue.push("ccc", 20)
    @queue.decrease_key("bbb", 5)
    @queue.decrease_key("ccc", 8)
    @queue.pop.should == "bbb"
    @queue.pop.should == "ccc"
    @queue.pop.should == "aaa"
  end
  
  spec "should raise error when new key is greater then old key while decreasing key" do
    @queue.push("aaa", 10)
    lambda { @queue.decrease_key("aaa", 20) }.should raise_error
  end
    
end
