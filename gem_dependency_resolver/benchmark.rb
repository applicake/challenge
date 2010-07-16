require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10
  before do
    klass = solution.constant
    @instance = klass.new
    @gems = {}
    for i in 1..25000
      deps = []
      j = 2
      while i * j <= 25000
        deps << (i * j).to_s
        j += 1
      end
      @gems[i.to_s] = deps
    end
  end
  action do
    @instance.resolve @gems
  end
end