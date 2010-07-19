require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @resolver = klass.new
  end
  
  spec "should correctly resolve dependencies" do
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
  
  spec "should raise error on cycle" do
    gems = {
      'aaa' => ['bbb'],
      'bbb' => ['ccc'],
      'ccc' => ['aaa']
    }
    lambda { @resolver.resolve(gems) }.should raise_error
  end
  
end
