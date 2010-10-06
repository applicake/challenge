require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do
  before do
    klass = @solution.constant
    @parser = klass.new
  end

  spec "should parse keywords" do
    @parser.parse("true").should == true
    @parser.parse("false").should == false
    @parser.parse("null").should == nil
  end

  spec "should parse numbers" do
    @parser.parse("42").should == 42
    @parser.parse("-12").should == -12
    @parser.parse("33.123").should == 33.123
    @parser.parse("-3.123").should == -3.123
    @parser.parse("0.1e1").should == 0.1e1
    @parser.parse("0.1e+1").should == 0.1e+1
    @parser.parse("0.1e-1").should == 0.1e-1
    @parser.parse("0.1E1").should == 0.1E1
  end

  spec "should parse strings" do
    @parser.parse(%Q{""}).should == String.new
    @parser.parse(%Q{"JSON"}).should == "JSON"
    @parser.parse('"nested \"quotes\""').should == %Q{nested "quotes"}
    @parser.parse(%Q{"\\n"}).should == "\n"
    @parser.parse(%Q{"\\u#{"%04X" % ?a}"}).should == "a"
  end

  spec "should parse arrays" do
    @parser.parse(%Q{[]}).should == Array.new
    @parser.parse(%Q{["JSON", 3.1415, true]}).should == ["JSON", 3.1415, true]
    @parser.parse(%Q{[1, [2, [3]]]}).should == [1, [2, [3]]]
  end

  spec "should parse objects" do
    @parser.parse(%Q{{}}).should == Hash.new
    @parser.parse(%Q{{"JSON": 3.1415, "data": true}}).should == {"JSON" => 3.1415, "data" => true}

    @parser.parse(<<-END_OBJECT).should == { "Array" => [1, 2, 3], "Object" => {"nested" => "objects"} }
    {"Array": [1, 2, 3], "Object": {"nested": "objects"}}
    END_OBJECT
    
  end

  spec "should parse errors" do
    lambda { @parser.parse("{") }.should raise_exception(RuntimeError)
    lambda { @parser.parse(%q{{"key": true false}}) }.should raise_exception(RuntimeError)
    lambda { @parser.parse("[") }.should raise_exception(RuntimeError)
    lambda { @parser.parse("[1,,2]") }.should raise_exception(RuntimeError)
    lambda { @parser.parse(%Q{"}) }.should raise_exception(RuntimeError)
    lambda { @parser.parse(%Q{"\\i"}) }.should raise_exception(RuntimeError)
    lambda { @parser.parse("$1,000") }.should raise_exception(RuntimeError)
    lambda { @parser.parse("1_000") }.should raise_exception(RuntimeError)
    lambda { @parser.parse("1K") }.should raise_exception(RuntimeError)
    lambda { @parser.parse("unknown") }.should raise_exception(RuntimeError)
  end
end
