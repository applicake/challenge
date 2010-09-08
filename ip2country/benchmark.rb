require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
  end

  action do
    ['83.29.122.34',
     '68.97.89.187', 
     '80.79.64.128', 
     '192.189.119.1', 
     '210.185.128.123', 
     '255.0.0.1'].each do |ip|

      @klass.new.find_country_by_ip(ip)
     end
  end
end                             
