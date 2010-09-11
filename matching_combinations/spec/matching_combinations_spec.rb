require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do
  
  before do
    klass = @solution.constant
    @object = klass.new
    puts klass
  end

  spec "0 for (1..4), and 12" do
    array = (1..4).to_a
    int = 12
    result = []

    @object.fetch_matching_comb(array, int).should == result
  end

  spec "1 for (1..3), and 1" do
    array = (1..3).to_a
    int = 1
    result = [[1]]

    @object.fetch_matching_comb(array, int).should == result
  end

  spec "4 for (1..8), and 4" do
    array = (1..8).to_a
    int = 4
    result = [[3,1], [2,2], [1,3], [4]]
    
    @object.fetch_matching_comb(array, int).should == result
  end

  spec "12 for (1..6), and 6" do
    array = (1..6).to_a
    int = 6
    result = [[3,2,1], [3,1,2], [2,3,1], [2,1,3], [1,3,2], [1,2,3], [5,1], [4,2], [3,3], [2,4], [1,5], [6]]
    
    @object.fetch_matching_comb(array, int).should == result
  end

end
