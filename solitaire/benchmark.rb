require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 100
  before do
    klass = solution.constant
    @instance = klass.new
  end
  action do
    @instance.decrypt('CLEPK HHNIY CFPWH FDFEH')
    @instance.decrypt('ABVAW LWZSY OORYK DUPVH')
  end
end
