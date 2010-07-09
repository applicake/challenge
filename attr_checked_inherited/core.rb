#require 'inheritance_fix'
module CheckedAttributes
  def self.included(base)
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end  
  
  module InstanceMethods
    def method_missing(name, *args)
      attribute_name = name.to_s.chop 
      if (block = self.class.instance_variable_get('@checked_attributes')[attribute_name])
        procced(attribute_name, args.first, block)
      else
        super
      end 
    end 
    
    def procced(name, value,  block) 
      if block.call(value)
        instance_variable_set("@#{name}", value)
        "OK"
      else 
        raise "Exception"
      end 
    end 
  end 

  module ClassMethods
    def attr_checked(attr_name, &block)
      attr_reader attr_name
      @checked_attributes ||= {}
      if block_given?
        @checked_attributes[attr_name.to_s] = block  
      else 
        raise Exception.new("Please specify block") 
      end 
    end 
  end 
end

#  method_missing_checked_attribute.rb:10:in `method_missing': undefined method `[]' for nil:NilClass (NoMethodError)
#	from method_missing_checked_attribute.rb:65

#
#


=begin
class Person 
  include CheckedAttributes
  #include InheritanceFix 
  attr_checked :age  do |v|
    v > 15
  end 
end
me = Person.new 
me.age = 39  #=> OK
me.age = 12  #=> Exception 

class Woman < Person
  attr_checked :age do |v| 
    v >= 10
  end  
end

ela = Woman.new
ela.age = 12  #=> OK
ela.age = 8 #=> Exception
me.age = 12 #=> Exception  

#So far so good but ...

class Mariusz < Person
end 

Mariusz.new.age = 18 
=end