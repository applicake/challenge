solutions = Dir.glob('solutions/*.rb').collect { |s| s.gsub('solutions/', '').gsub('.rb', '') }


solutions.each do |solution|
  require "solutions/#{solution}.rb"
      
  describe "#{solution}" do   
    
    before do
      mod = solution.split('_').collect { |part| part.capitalize }.join('')
      klass_name = "Tester_#{solution}"
      eval <<-STR
        class #{klass_name}
          include #{mod}
          #{solution}_attr_checked :age do |v|
            v >= 18
          end
        end
      STR
      klass = Object.const_get(klass_name)
      @instance = klass.new
    end
    
    
    it "should work as a setter and a getter" do
      @instance.age = 20
      @instance.age.should == 20
    end

    it "should not work as a setter when value is not valid" do
      lambda { @instance.age = 9 }.should raise_exception
      @instance.age.should_not == 9
    end
    
  end
end
