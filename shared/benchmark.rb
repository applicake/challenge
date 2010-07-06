def present_leaderboard(hash, key = nil)  
  puts "\n=== Results for #{key}:"
  hash.sort {|a,b| a[1]<=>b[1]}.each do |result|
    buffer = 11 - result[0].size
    print "#{result[0]}:"
    buffer.times { print(' ') }
    puts "#{result[1]}"
  end
end

def run_benchmark(lambdas_to_use, solutions, lambdas, leaderboard)
  lambdas_to_use.each do |key|
    puts "=== #{key}"
    Benchmark.bm do |x|
      solutions.each do |solution|
        report = x.report("#{solution[1]}:") do
          lambdas[key].call(solution)
        end
        leaderboard[key][solution[1]] = report.real
      end
    end
    present_leaderboard(leaderboard[key], key)
  end
end

def load_solutions
  solutions = Dir.glob('solutions/*.rb').collect { |s| s.gsub('solutions/', '').gsub('.rb', '') }
  solutions.collect do |solution|
    mod = solution.gsub('_', ' ').capitalize.gsub(' ', '')
    require "solutions/#{solution}.rb"
    [solution, mod]    
  end
end