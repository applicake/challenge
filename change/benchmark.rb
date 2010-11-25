require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
  end

  action do
    @instance = @klass.new
    @instance.change(12345678, [1,2,3,4,5])
    @instance.change(87654321, [1,2,3,4,5])
  end

end
