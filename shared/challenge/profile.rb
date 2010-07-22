# This file hacks into the Benchmark class and turns it into a profiler
module Challenge
  class Benchmark
    
    def header
      puts "Profiling #{solutions.size} solution(s) at #{iterations} iteration(s)...\n\n"
    end
    
    def footer
    end
    
    def perform
      puts "Profiling: #{use}"
      before.call if before
      RubyProf.start
      iterations.times { action.call }
      result = RubyProf.stop
      render result
    end
    
    def command(solution)
      "ruby profile.rb #{solution.name} --quiet"
    end
        
    def render(result)
      puts "\n"
      printer = RubyProf::FlatPrinter.new(result)
      printer.print(STDOUT, 0)
    end
    
  end
end