require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @resolver = klass.new
  end
  
  spec "should correctly resolve dependencies" do
    gems = {}
    result = []
    str = 'a' 
    (1..100000).each do |t| 
      result.unshift str 
      gems[str] = [str.next]
      str = str.next 
    end  
    gems[str] = []  
    result.unshift str 
    @resolver.resolve(gems).should == result

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
    gems = {
      'aaa' => ['bbb', 'ccc'],
      'bbb' => [],
      'ccc' => [],
      'ddd' => 'aaa'
    }
  end

  spec "should raise error on cycle" do
    gems = {
      'aaa' => ['bbb'],
      'bbb' => ['ccc'],
      'ccc' => ['aaa']
    }
    lambda { @resolver.resolve(gems) }.should raise_error
  end

  spec "should find nested dependencies" do
    gems = {
      'aaa' => ['ccc'],
      'bbb' => [],
      'ccc' => ['bbb']
    }
    @resolver.resolve(gems).should  == ['bbb', 'ccc', 'aaa']
  end
  
  spec "should correctly resolve dependecies in benchmark" do
      @gems = {}
      for i in 1..250
        deps = []
        j = 2
        while i * j <= 250
          deps << (i * j).to_s
          j += 1
        end
        @gems[i.to_s] = deps
      end
      #puts "Gem '60' deps: #{@gems['60'].inspect}"
      dependencies = @gems.dup
      result = @resolver.resolve(@gems)
      #puts result
      result.length.should == dependencies.length
      positions = {}
      result.each_with_index do |gem, index|
        positions[gem] = index
      end
      result.each do |gem|
        dependencies[gem].each do |previous|
          positions[previous].should < positions[gem]
        end
      end
    end
  
end
