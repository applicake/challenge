solutions = Dir.glob('solutions/*.rb').collect { |s| s.gsub('solutions/', '').gsub('.rb', '') }

solutions.each do |solution|
  require "solutions/#{solution}.rb"
  describe "#{solution} slice" do   
  
    it "should satisfy client requirements" do
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice").should == [[1, 2, 3, 4, 5, 6, 7, 8, 9]] 
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice", 3).should == [[1, 2], [4, 5, 6, 7, 8, 9]]
      [1, 2, 3, 4, 5, 6, 4, 8, 9].send("#{solution}_slice", 4).should == [[1, 2, 3], [5, 6], [8, 9]]
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice") {|i| i%3 == 0}.should == [[1, 2], [4, 5], [7, 8], []]
      [2, 3, 2, 2, 2].send("#{solution}_slice", 2).should == [[], [3], [], [], []]
    end
    
    # Look, ma, it works with nils!
    it "should work with nils" do
      [1, 2, 3, 4, 5, 6, 7, 8, 9, nil].send("#{solution}_slice").should == [[1, 2, 3, 4, 5, 6, 7, 8, 9, nil]] 
      [1, 2, 3, 4, nil, 5, 6, 7, 8, 9, nil].send("#{solution}_slice", 3).should == [[1, 2], [4, nil, 5, 6, 7, 8, 9, nil]]
      # it's up to the block provider to make sure that the element handles modulo
      [1, 2, 3, 4, 5, 6, 7, 8, 9, nil].send("#{solution}_slice") {|i| i and i%3 == 0}.should == [[1, 2], [4, 5], [7, 8], [nil]]
    end
    
    it "should return array of one slice (whole input array) when called without argument" do
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice").should == [[1, 2, 3, 4, 5, 6, 7, 8, 9]] 
    end      

    it "should partition array when divider is found" do
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice", 3).should == [[1, 2], [4, 5, 6, 7, 8, 9]] 
    end

    it "should return array of slices of input array divided by element equal to input argument" do
      [1, 2, 3, 4, 5, 6, 4, 8, 9].send("#{solution}_slice", 4).should == [[1, 2, 3], [5, 6], [8, 9]]
    end

    it "should return array of slices of input array divided by element for which block condition is true" do
      [1, 2, 3, 4, 5, 6, 7, 8, 9].send("#{solution}_slice") {|i| i%3 == 0}.should == [[1, 2], [4, 5], [7, 8], []]
    end

    it "should produce empty slice when divider is at the end" do
      [1, 2, 3].send("#{solution}_slice", 3).should == [[1, 2], []]
    end     

    it "should produce empty slice when divider is at the beginning" do
      [1, 2, 3].send("#{solution}_slice", 1).should == [[], [2, 3]]
    end

    it "should produce empty slice when divider is next to other divider" do
      [1, 2, 3, 3, 5].send("#{solution}_slice", 3).should == [[1, 2], [], [5]]
    end
    
    # These are taken from the Rails test suite
    it "should test_split_with_empty_array" do
       [].send("#{solution}_slice", 0).should == [[]]
    end

    it "should test_split_with_argument" do
       [1, 2, 3, 4, 5].send("#{solution}_slice", 3).should == [[1, 2], [4, 5]]
       [1, 2, 3, 4, 5].send("#{solution}_slice", 0).should ==  [[1, 2, 3, 4, 5]]
    end

    it "should test_split_with_block" do
      (1..10).to_a.send("#{solution}_slice") { |i| i % 3 == 0 }.should == [[1, 2], [4, 5], [7, 8], [10]]
    end

    it "should test_split_with_edge_values" do
      [1, 2, 3, 4, 5].send("#{solution}_slice", 1).should == [[], [2, 3, 4, 5]]
      [1, 2, 3, 4, 5].send("#{solution}_slice", 5).should == [[1, 2, 3, 4], []]
      [1, 2, 3, 4, 5].send("#{solution}_slice") { |i| i == 1 || i == 5 }.should == [[], [2, 3, 4], []]
    end
        
    
  end
end
