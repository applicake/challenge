require 'benchmark'
require File.dirname(__FILE__) + '/../shared/benchmark'

# Objects for testing
class Tester
end
klass = Tester

# solutions
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

solutions.each do |name, mod|
  klass.send :include, Object.const_get(mod)
end


# Number of iterations
n = 200000

# Lambdas available
lambdas = {
  :simple => lambda { |solution|
    klass.send("#{solution[0]}_attr_checked", :age) { |v| v >= 18 }
    instance = klass.new
    n.times do 
      instance.age = 48
      begin
        instance.age = 9 
      rescue 
      end
    end
  }
}

# Lambdas to be used
lambdas_to_use = [:simple]

# Standings container
leaderboard = {
  :simple => {}
}

run_benchmark(lambdas_to_use, solutions, lambdas, leaderboard)
