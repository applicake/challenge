require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
    @instance = @klass.new
    srand(666)
  end

  action do
    (1..999).each do |n|
      @instance.add_friendship(n, n + 1)
    end
    @instance.shortest_path(1, 1000)
    (500..998).each do |n|
      @instance.remove_friendship(n, n+1) 
    end
    20000.times do 
      @instance.add_friendship(1 + rand(500), 1 + rand(500))
    end
    @instance.shortest_path(1 + rand(500), 1 + rand(500))

  end

end                             
