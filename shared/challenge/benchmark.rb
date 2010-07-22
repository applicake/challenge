require 'stringio'
require 'benchmark'
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
        @solutions = Challenge::Solution.load(self.name)
        title 
        header
        # If nothing is supplied, run all, but in separate processes
        @solutions.each { |solution| system command(solution) }
        footer
        exit
      end
      trap('INT') { puts "\rSkipping #{use}..."; exit }
      title("\n") unless OPTIONS.include?('--quiet')
      solution Challenge::Solution.find(self.name, use)
      perform
      footer unless OPTIONS.include?('--quiet')
    end
    
    def title(addon = nil)
      puts "Challenge: #{self.name}#{addon}\n"      
    end
    
    def header
      puts "Running #{@solutions.size} solution(s) at #{iterations} iteration(s)...\n\n"
    end
    
    def footer
      puts "\nThe given time is an average for one iteration" 
    end
    
    def command(solution)
      "ruby benchmark.rb #{solution.name} --quiet"
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