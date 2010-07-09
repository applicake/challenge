require 'stringio'
def present_leaderboard(hash, key = nil)  
  hash.sort {|a,b| a[1]<=>b[1]}.each do |result|
    buffer = 15 - result[0].size
    print "#{key} - #{result[0]}:"
    buffer.times { print(' ') }
    puts "#{result[1]}"
  end
end

def run_benchmark(lambdas_to_use, solutions, lambdas, leaderboard)
  lambdas_to_use.each do |key|
    $stdout, old_stdout = StringIO.new, $stdout
    Benchmark.bm do |x|
      solutions.each do |solution|
        report = x.report("#{key} - #{solution[1]}:") do
          lambdas[key].call(solution)
        end
        leaderboard[key][solution[1]] = report.real
      end
    end
    $stdout = old_stdout
    present_leaderboard(leaderboard[key], key)
  end
end

def load_solutions
  solutions = Dir.glob('solutions/*.rb').collect { |s| s.gsub('solutions/', '').gsub('.rb', '') }
  solutions.collect do |solution|
    mod = solution.split('_').collect { |part| part.capitalize }.join('')
    require "solutions/#{solution}.rb"
    [solution, mod]    
  end
end