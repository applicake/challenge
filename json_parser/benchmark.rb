require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10000
  before do
    @klass = solution.constant
    @instance = @klass.new
  end

  action do
    #TODO
    @instance.parse(%Q{{"JSON": 3.1415, "data": true, "Array": [1, 2, 3]}})
  end

end                             
