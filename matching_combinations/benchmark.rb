require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1

  before do
    @klass = solution.constant
  end

  action do
    @instance = @klass.new

    @instance.fetch_matching_comb (1..4).to_a, 12
    @instance.fetch_matching_comb (1..3).to_a, 1
    @instance.fetch_matching_comb (1..8).to_a, 4
    @instance.fetch_matching_comb (1..6).to_a, 6
    @instance.fetch_matching_comb (1..12).to_a, 8
    @instance.fetch_matching_comb (1..16).to_a, 12
  end
end
