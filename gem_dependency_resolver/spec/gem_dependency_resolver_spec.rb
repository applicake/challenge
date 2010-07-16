# Ten spec to narazie typowy spec a nie Challenge::Spec bo coś mi nie chciało
# działać :( . Jak pogadam z Marcinem to podmienię.

require File.dirname(__FILE__) + "/../solutions/resolver.rb"

describe Resolver do
  
  before :all do
    @resolver = Resolver.new
  end
  
  it "should correctly resolve dependencies" do
    gems = {
      'aaa' => ['bbb', 'ccc', 'ddd', 'eee'],
      'bbb' => ['ccc', 'ddd', 'eee'],
      'ccc' => ['ddd', 'eee'],
      'ddd' => ['eee'],
      'eee' => []
    }
    @resolver.resolve(gems).should == ['eee', 'ddd', 'ccc', 'bbb', 'aaa']
    gems = {
      'aaa' => ['bbb', 'ccc'],
      'bbb' => ['ccc'],
      'ccc' => [],
      'ddd' => []
    }
    @resolver.resolve(gems).should satisfy do |result|
      result == ['ddd', 'ccc', 'bbb', 'aaa'] or 
        result == ['ccc', 'ddd', 'bbb', 'aaa'] or
        result == ['ccc', 'bbb', 'ddd', 'aaa'] or
        result == ['ccc', 'bbb', 'aaa', 'ddd']
    end
  end
  
  it "should raise error on cycle" do
    gems = {
      'aaa' => ['bbb'],
      'bbb' => ['ccc'],
      'ccc' => ['aaa']
    }
    lambda { @resolver.resolve(gems) }.should raise_error
  end
  
end 