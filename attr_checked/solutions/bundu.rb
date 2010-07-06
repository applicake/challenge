module Bundu

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def bundu_attr_checked(attribute, &block)
      attr_reader attribute
      define_method "#{attribute}=" do |value|
        raise "#{attribute} not valid" unless block.call(value)
        instance_variable_set("@#{attribute}", value)
      end
    end
    
  end
  
end