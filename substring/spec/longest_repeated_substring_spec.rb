require File.dirname(__FILE__) + '/../../shared/spec' unless defined?(Challenge)
require 'ruby-debug'

Challenge::Spec.new do

  before do
    klass = @solution.constant
    @substring = klass.new
  end
  
  spec "Banan test" do
    @substring.fetch_substring("banan").should == "an" 
  end
  
  spec "No substring text" do
    @substring.fetch_substring('norepeatedsubstring').should == ''
  end
  
  spec "Text with spaces" do
    @substring.fetch_substring('repeateat substring with spaces').should == 'eat'
  end
  
  spec "Text with two substrings of same length" do
    @substring.fetch_substring('doubledoublestringstring').should == 'double string'
  end
  
  spec "Very long word test" do
      @substring.fetch_substring("verylongwordlonglongblebleblelongwordlongwordlongveryveryverybleverylongwordveryveryveryverylongwordveryveryverybleblewordword").should == 'verylongwordveryveryvery'
  end
    
end