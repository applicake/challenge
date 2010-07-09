module Challenge
  class Solution
  
    attr_accessor :name, :constant
    
    def initialize(opts)
      opts.each_pair { |key, value| self.send("#{key}=", value) }
    end
    
    class << self
      
      def find(challenge, solution)
        solutions = Dir.glob("#{CHALLENGE_BASE_PATH}/#{challenge}/solutions/#{solution}.rb").collect { |s| s.split('/').last.gsub('.rb', '') }
        solution = solutions.first        
        mod = solution.split('_').collect { |part| part.capitalize }.join('')
        require "#{CHALLENGE_BASE_PATH}/#{challenge}/solutions/#{solution}.rb"
        Solution.new(:name => solution, :constant => Object.const_get(mod))
      end
      
      def load(challenge)
        solutions = Dir.glob("#{CHALLENGE_BASE_PATH}/#{challenge}/solutions/*.rb").collect { |s| s.split('/').last.gsub('.rb', '') }
        solutions.collect do |solution|
          mod = solution.split('_').collect { |part| part.capitalize }.join('')
          require "#{CHALLENGE_BASE_PATH}/#{challenge}/solutions/#{solution}.rb"
          Solution.new(:name => solution, :constant => Object.const_get(mod))
        end
      end
      
    end
        
  end
end