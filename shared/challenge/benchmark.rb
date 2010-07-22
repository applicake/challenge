require 'stringio'
module Challenge
  class Benchmark
    include ::Benchmark
    extend DslAccessor
    dsl_accessor :name, :iterations, :action, :before, :use, :solutions, :solution, :verbose

    def initialize(name = nil, &block)
      self.name name ||  Dir.pwd.split('/').last.to_s
      instance_eval(&block)
      use ARGV[0] 
      if !use
        solutions = Challenge::Solution.load(self.name)
        puts "Challenge: #{self.name}\n"
        puts "Running #{solutions.size} solution(s) at #{iterations} iteration(s)...\n\n"
        
        # If nothing is supplied, run all, but in separate processes
        solutions.each { |solution| system "ruby benchmark.rb #{solution.name} --quiet" }
        puts "\nThe given time is an average for one iteration"
        exit
      end
      unless ARGV.include?('--quiet')
        puts "Challenge: #{self.name}\n\n"
      end
      solution Challenge::Solution.find(self.name, use)
      perform
      puts "\nThe given time is an average for one iteration" unless ARGV.include?('--quiet')
    end
    
    def perform
      before.call if before
      time = nil
      $stdout, old_stdout = StringIO.new, $stdout unless verbose
      report = measure do
        iterations.times { action.call }
      end
      time = report.real / iterations.to_f # get the average time
      $stdout = old_stdout unless verbose
      render time
    end
    
    def render(time)
      width = 12
      if use.length < width
        puts "#{use}:#{' ' * (width - use.length + 1)} #{time} seconds"
      else
        puts "#{use[0..width]}: #{time} seconds"
      end
    end
    
  end
end