module Michal 
  module ClassMethods
    def michal_attr_checked(sym, &block)
      define_method "#{sym}=" do |value|
        raise "Exception" if block and !block.call(value)
        instance_variable_set("@#{sym}", value)
      end

      define_method "#{sym}" do
        instance_variable_get("@#{sym}")
      end
    end
  end

   
  def self.included(base)
    base.extend(ClassMethods)
  end
end
