require File.dirname(__FILE__) + '/../shared/benchmark' # unless defined?(Challenge)

Challenge::Benchmark.new do
  iterations 1
  before do
    @klass = solution.constant
    @instance = @klass.new

    s =  %Q{"JSON": 3.1415, "data": true, "Object": {"nested": "objects", "JSON": 3.1415, "data": {"nested": "objects"}}, "Array": [1, 2, 3, 6, 10, 234, 323, 23, 2321], }
    j = ""
    2500.times { j << s }
    @data = "{" + j.chop!.chop! + "}"
  end

  action do
    @instance.parse(@data)
  end

end                             
