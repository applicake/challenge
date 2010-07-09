module Dominik 
  module ClassMethods
    def dominik_attr_checked(name, &block)
      attr_reader name
      define_method("#{name}=") do |val|
        if block.call(val)
          instance_variable_set("@#{name}", val)
        else
          raise "Exception"
        end
      end
    end
  end
  
  def self.included(host_class)
    host_class.extend(ClassMethods)
  end
end
