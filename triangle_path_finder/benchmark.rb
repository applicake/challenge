require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
    srand(666)
    MAX_NUM = 1000
    HEIGHT = 1000
    @triangle = (1..HEIGHT).map do |level|
      Array.new(level) { rand(MAX_NUM) }.join(" ")
    end.join("\n")
  end

  action do
    @instance = @klass.new
    @instance.best_path(@triangle).to_s
  end

end
