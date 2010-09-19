require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do
  before do
    klass = @solution.constant
    @obj = klass.new
    @obj.add_friendship('Alice', 'Bob')
    @obj.add_friendship('Charlie', 'Bob')
    @obj.add_friendship('Charlie', 'Dick')
  end
  
  spec "can't comprehend that Alice and Bob like each other" do
    @obj.shortest_path('Alice', 'Bob').should == %w[Alice Bob] 
    @obj.shortest_path('Bob', 'Alice').should == %w[Bob Alice] 
  end

  spec "does not seem to realize that Alice can quickly get to know Dick" do
    @obj.shortest_path('Alice', 'Dick').should == %w[Alice Bob Charlie Dick] 
  end

  spec "fails to acknowledge she can get through to Dick faster now that she is BFF with Charlie" do
    @obj.add_friendship('Charlie', 'Alice')
    @obj.shortest_path('Alice', 'Dick').should == %w[Alice Charlie Dick] 
  end

  spec "wrongly assumes that she can't get to Dick when she likes Charlie but not Bob" do
    @obj.add_friendship('Charlie', 'Alice')
    @obj.remove_friendship('Bob', 'Alice')
    @obj.shortest_path('Alice', 'Dick').should == %w[Alice Charlie Dick] 
  end

  spec "fails to notice that Alice was eliminated from the social circle" do
    @obj.remove_friendship('Bob', 'Alice')
    @obj.shortest_path('Alice', 'Dick').should == []
    @obj.shortest_path('Alice', 'Bob').should == []
    @obj.shortest_path('Alice', 'Charlie').should == []
  end

  spec "can't see that guys still know each other very well" do
    @obj.remove_friendship('Bob', 'Alice')
    @obj.shortest_path('Bob', 'Dick').should == %w[Bob Charlie Dick]
    @obj.shortest_path('Charlie', 'Bob').should == %w[Charlie Bob]
    @obj.shortest_path('Dick', 'Charlie').should == %w[Dick Charlie]
  end

  spec "can't even find one way to Charlie" do
    @obj.add_friendship('Alice', 'Dick')
    path = @obj.shortest_path('Alice', 'Charlie')
    (path == %w[Alice Bob Charlie] or path == %w[Alice Dick Charlie]).should == true
  end

  spec "didn't admit that you know $h!t about Tarzan's and Jane's relationship" do
    @obj.shortest_path('Jane', 'Tarzan') == []
  end

  spec "doesn't ignore egoists" do
    @obj.add_friendship("Fred", "Fred")
    @obj.shortest_path("Fred", "Fred").should == [] 
    @obj.shortest_path("Alice", "Alice").should == []
  end

  spec "is not prepared for a lot of friendship" do
    lambda { 
      @obj.add_friendship("Alice", "Bob") 
      @obj.add_friendship("Alice", "Bob")  
    }.should_not raise_error
    @obj.shortest_path("Alice", "Bob").should == %w[Alice Bob]
    @obj.shortest_path("Alice", "Charlie").should == %w[Alice Bob Charlie]
  end
  spec "is not ready for excessive hate" do
    lambda { 
      @obj.remove_friendship("Alice", "Bob") 
      @obj.remove_friendship("Alice", "Bob")  
    }.should_not raise_error
    @obj.shortest_path("Alice", "Bob").should == []
    @obj.shortest_path("Alice", "Charlie").should == []
    @obj.shortest_path("Bob", "Charlie").should == %w[Bob Charlie]
  end
end
