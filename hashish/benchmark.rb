require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10000
  before do
    klass = solution.constant
    @instance = klass.new
  end
  action do
  end
end
