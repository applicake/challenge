module Kiszalnoeval 
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
      else 
        raise "#{name} not valid" 
      end 
    end 
  end 

  module ClassMethods
    def kiszalnoeval_attr_checked(attr_name, &block)
      @checked_attributes ||= {}
      attr_reader attr_name
      if block_given?
        @checked_attributes[attr_name.to_s] = block  
      else 
        raise Exception.new("Please specify block") 
      end 
    end 
  end 
end


