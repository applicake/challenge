require 'benchmark'
require File.dirname(__FILE__) + '/../shared/benchmark'

require 'core.rb'
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

Solution = Object.const_get(solutions.first.last)

require File.dirname(__FILE__) + '/core'

puts Solution
class Person 
  include CheckedAttributes
  include Solution 
  attr_checked :age  do |v|
    v > 15
  end 
end

class Mariusz < Person
end 


# Number of iterations
n = 10000

# Lambdas available
lambdas = {
  :simple => lambda { |solution|    
    instance = Mariusz.new
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