require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10000
  before do
    Array.send :include, solution.constant
  end
  action do
    [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution.name}_slice", 3)
    [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution.name}_slice") {|i| i%3 == 0}
    [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution.name}_slice") {|i| i/3 == 0}
  end
end
