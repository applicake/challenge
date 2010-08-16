require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1000
  before do
    klass = solution.constant
    @instance = klass.new
  end
  action do
    @instance.fetch_substring('verylongwordlonglongblebleblelongwordlongwordlongveryveryverybleverylongwordveryveryveryverylongwordveryveryverybleblewordword')
  end
end