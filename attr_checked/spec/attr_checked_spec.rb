solutions = Dir.glob('solutions/*.rb').collect { |s| s.gsub('solutions/', '').gsub('.rb', '') }
class Tester; end

solutions.each do |solution|
  require "solutions/#{solution}.rb"
  mod = solution.gsub('_', ' ').capitalize.gsub(' ', '')
  Tester.send :include, Object.const_get(mod)
  Tester.send("#{solution}_attr_checked", :age) { |v| v >= 18 }
    
  describe "#{solution}" do   
  
    before do
      @instance = Tester.new
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
