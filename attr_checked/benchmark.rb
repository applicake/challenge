require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10000
  before do
    class Tester; end    
    Tester.send :include, solution.constant
    Tester.send("#{solution.name}_attr_checked", :age) { |v| v >= 18 }
    @instance = Tester.new
  end
  action do
    @instance.age = 48
    begin
      @instance.age = 9 
    rescue 
    end
  end
end
