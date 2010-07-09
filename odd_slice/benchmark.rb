require 'benchmark'
require File.dirname(__FILE__) + '/../shared/benchmark'

solutions = load_solutions

if ARGV[0] == nil
  solutions.each do |solution|
    cmd = "ruby benchmark.rb #{solution[0]}"
    system cmd
  end
  exit
else
  solutions = solutions.select { |s| s[0] == ARGV[0] }
end

# Number of iterations
n = 50000

# Lambdas available
lambdas = {
  :value => lambda { |solution|
    n.times do [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice", 3) end
  },
  :block_a => lambda { |solution|
    n.times do [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice") {|i| i%3 == 0} end
  },
  :block_b => lambda { |solution|
    n.times do [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice") {|i| i/3 == 0} end
  },
  :all => lambda { |solution|
    n.times do 
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice", 3)
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice") {|i| i%3 == 0}
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution[0]}_slice") {|i| i/3 == 0}
    end
  }
}
# Lambdas to be used
lambdas_to_use = [:all]

# Standings container
leaderboard = {
  :value => {},
  :block_a => {},
  :block_b => {},
  :all => {}
}

run_benchmark(lambdas_to_use, solutions, lambdas, leaderboard)
