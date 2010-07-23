require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @hashish = klass.new
  end
  
  %w[fetch delete].each do |method|
    spec "raises error when trying to #{method} nonexistent value" do
      expect {
        @hashish.send(method, "unknown")
      }.to raise_error
      @hashish.store("known", "value")
      expect {
        @hashish.send(method, "other unknown")
      }.to raise_error
      @hashish.delete("known")
      expect {
        @hashish.send(method, "known")
      }.to raise_error
    end
  end

  spec "knows what keys it has" do
    @hashish.has_key?("key").should == false
    @hashish.store("key", "value")
    @hashish.has_key?("key").should == true
    @hashish.delete("key")
    @hashish.has_key?("key").should == false
  end


  spec "overrides values" do
    @hashish.store("key", "value")
    @hashish.fetch("key").should == "value"
    @hashish.store("key", "another value")
    @hashish.fetch("key").should == "another value"
  end

  spec "fetches correct value for known key" do
    value = "value"
    @hashish.store("a key", value)
    @hashish.fetch("a key").should == "value"
    value = "another value"
    @hashish.fetch("a key").should == "value"
    @hashish.store("another key", "even other value")
    @hashish.fetch("another key").should == "even other value"
    @hashish.fetch("a key").should == "value"
  end

  spec "length works correctly" do
    expect {
      @hashish.store("key", "value")
    }.to change(@hashish, :length).from(0).to(1)
    lambda {
      @hashish.store("key", "another value")
    }.should_not change(@hashish, :length)
    expect {
      @hashish.store("another key", "value")
    }.to change(@hashish, :length).from(1).to(2)
    expect {
      @hashish.delete("another key")
    }.to change(@hashish, :length).from(2).to(1)
    lambda {
      @hashish.fetch("key")
    }.should_not change(@hashish, :length)

    lambda {
      @hashish.has_key?("key")
      @hashish.has_key?("another key")
    }.should_not change(@hashish, :length)
    expect {
      @hashish.delete("key")
    }.to change(@hashish, :length).from(1).to(0)
  end

  spec "source cannot contain forbidden characters" do
    forbidden_characters = /[{}"'`:%]/
    source_lines = File.new(File.dirname(__FILE__) + "/../solutions/#{@solution.name}.rb", "r").map { |line| line }
    source_lines.each do |line| 
      line.should_not match(forbidden_characters)
    end
   # raise source 
  end

  spec "does not invoke forbidden methods" do
    key, value = stub
    Hash.should_not_receive(:new)
    key.stub(:dup).and_return(key)
    key.stub(:clone).and_return(key)
    key.should_not_receive(:hash)

    hashish = @solution.constant.new
    hashish.store(key, value)
    hashish.fetch(key)
    hashish.has_key?(key)
    hashish.delete(key)
  end

end
