require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
  end
  action do
    @instance = @klass.new
    @instance.fetch_less_then(10000)
  end
  
end
