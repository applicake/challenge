require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 10
  before do
    klass = solution.constant
    @instance = klass.new
  end
  action do
    secret = @instance.encrypt('Aa@' * 5000)
    plain = @instance.decrypt secret
  end
end

# 'Aa@' * 50000
# solitaire - bundu: 88.7629518508911 seconds
# 'Aa@' * 5000
# solitaire - bundu: 8.55243992805481 seconds
# 'Aa@' * 500 
# solitaire - bundu: 0.8348069190979 seconds
