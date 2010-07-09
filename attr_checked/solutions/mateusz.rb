module Mateusz 
  def self.included(base)
    class << base
      attr_accessor :attr_checked_validations
    end
    base.attr_checked_validations = {}
    base.send :extend, ClassMethods
  end
  



  module ClassMethods

    def mateusz_attr_checked(name, &block)
      self.attr_checked_validations[name.to_sym] = block
      
      class_eval(<<-SETTER)
        def #{name}=(value)
          raise "WRONG" unless self.class.attr_checked_validations[:#{name}].call(value)
          @#{name} = value
        end
      SETTER
    
      attr_reader name.to_sym
    end
  end
end

