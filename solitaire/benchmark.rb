require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10
  before do
    klass = solution.constant
    @instance = klass.new
  end
  action do
    secret = @instance.encrypt( 'Aa@' * 500)
    plain = @instance.decrypt secret
  end
end
