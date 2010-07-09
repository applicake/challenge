module BunduFast

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def bundu_fast_attr_checked(attribute, &block)
      attr_reader attribute
      (class << self; self; end).instance_eval { attr_accessor "_#{attribute}_callback" }
      send("_#{attribute}_callback=", block)
      class_eval <<-STR
        def #{attribute}=(value)
          if self.class._#{attribute}_callback.call(value)
             @#{attribute} = value
           else
             raise "#{attribute} not valid"
           end
        end
      STR
    end
    
  end
  
end
