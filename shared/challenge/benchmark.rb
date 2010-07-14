require 'stringio'
module Challenge
  class Benchmark
    extend DslAccessor
    dsl_accessor :name, :iterations, :action, :before, :use, :solutions, :solution

    def initialize(name = nil, &block)
      self.name name ||  Dir.pwd.split('/').last.to_s
      instance_eval(&block)
      use ARGV[0] 
      if !use
        # If nothing is supplied, run all, but in separate processes
        Challenge::Solution.load(self.name).each { |solution| system "ruby benchmark.rb #{solution.name}" }
        exit
      end
      solution Challenge::Solution.find(self.name, use)
      perform
    end
    
    def perform
      before.call if before
      time = nil
      $stdout, old_stdout = StringIO.new, $stdout
      ::Benchmark.bm(iterations) do |x|
        report = x.report("#{name} - #{use}:") do
          action.call
        end
        time = report.real
      end
      $stdout = old_stdout
      render time
    end
    
    def render(time)
      puts "#{name} - #{use}: #{time} seconds"
    end
    
  end
end