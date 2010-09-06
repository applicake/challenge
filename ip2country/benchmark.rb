require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
  end
  action do
    @instance = @klass.new
    @instance.find_country_by_ip('83.29.122.34')
    @instance.find_country_by_ip('68.97.89.187')
    @instance.find_country_by_ip('80.79.64.128')
    @instance.find_country_by_ip('192.189.119.1')
    @instance.find_country_by_ip('210.185.128.123')
    @instance.find_country_by_ip('255.0.0.1')
  end
end                             
