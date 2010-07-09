module Bundunoeval

  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module InstanceMethods
  
    def method_missing(method, *args)
      attribute = method.to_s[0..-2]
      if method.to_s[-1].chr == '=' && respond_to?(attribute)
        block = self.class.send("_#{attribute}_callback_no_eval")
        raise "#{attribute} not valid" unless block.call(args.first)
        instance_variable_set("@#{attribute}", args.first)
      else
        super
      end
    end
    
  end
  
  module ClassMethods
    
    def bundunoeval_attr_checked(attribute, &block)
      include InstanceMethods
      attr_reader attribute
      (class << self; self; end).send :attr_accessor, "_#{attribute}_callback_no_eval"
      send("_#{attribute}_callback_no_eval=", block)
    end
    
  end
  
end
