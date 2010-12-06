require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10
  before do
    @klass = solution.constant
    @default_layout = [[1,2,3],[4,5,6],[7,8,9],[0,'*',nil]]
    @instance = @klass.new(@default_layout)
  end
  action do
    3600.times {|seconds| @instance.quickest_sequence(seconds)}
  end
end
