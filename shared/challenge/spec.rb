module Challenge
  class Spec
    
    attr_accessor :name
    
    def initialize(name = nil, &block)
      self.name= name ||  Dir.pwd.split('/').last.to_s
      @solutions = Challenge::Solution.load(self.name)
      @specs = []
      instance_eval(&block)
      build
    end 
    
    def before(&block)
      @before = block
    end
    
    def spec(label, &block)
      @specs << { :label => label, :block => block }
    end
    
    def build
      specs = @specs
      before_call = @before
      @solutions.each do |solution|        
        describe solution.name do
          before do
            @solution = solution
            instance_eval(&before_call)
          end
          specs.each do |spec|
            it spec[:label], &spec[:block]
          end
        end
      end
    end
    
  end
end