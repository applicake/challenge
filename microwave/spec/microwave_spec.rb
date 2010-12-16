require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    @klass = @solution.constant
    @default_layout = [[1,2,3],[4,5,6],[7,8,9],[0,'*',nil]]
    @instance = @klass.new(@default_layout)
  end
  
  spec "should accept keyboard layout at initialization" do
    @klass.new([[1,2],[3,4]]).layout.should == [[1,2],[3,4]]
  end
  
  spec "should accept seconds and return key sequences as string" do
    @instance.quickest_sequence(60).should be_a(String)
  end

  spec "should end each sequence with a *" do
    @instance.quickest_sequence(60).should =~ /^[0-9]+\*$/
  end

  COMBINATIONS = {
    60 => '60*',    
    99 => '99*', 
    71 => '111*',
    3 => '3*',  
    1595 => '2635*', # jacek źle liczy 
  }


  COMBINATIONS.each do |seconds, result|
    spec "should return #{result.inspect} for #{seconds}s" do
      @instance.quickest_sequence(seconds).should == result
    end
  end

  spec "should use correct metric" do
    layout = [
      [ 1, '*',  0  ],
      [ 5,  3,   4  ],
      [ 2,  6,   7  ],
      [ 8,  9,  nil ]
    ]
    @klass.new(layout).quickest_sequence(130).should == '130*'
  end
end
