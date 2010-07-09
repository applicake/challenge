module Kiszal
  def self.included(base)
    base.extend ClassMethods
  end  

  module ClassMethods
    def kiszal_attr_checked(attr_name, &block)
      attr_reader attr_name
      class_eval do 
        define_method "#{attr_name}=" do |v| 
          if block and block.call(v)
            instance_variable_set("@#{attr_name}", v)
          else 
            raise "#{attr_name} not valid" 
          end 
        end   
      end 
    end 
  end 
 
end


