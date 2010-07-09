module Jaceknoeval 
  def self.included(klass)
    klass.send :include, InstanceMethods
    klass.extend ClassMethods
  end

  module ClassMethods
    def jaceknoeval_attr_checked(name, &block)
      unless block_given?
        raise Exception.new('You\'ve got to specify a validation block fool!')
      end
      attr_reader name
      @check_blocks ||= {}
      @check_blocks[name] = block
    end

    def check_blocks
      @check_blocks
    end
  end

  module InstanceMethods
    def assign_with_check(attr_name, value)
      if self.class.check_blocks[attr_name].call(value)
        self.instance_variable_set "@#{attr_name}".to_sym, value
      else
        raise 'Condition not passed..'
      end
    end

    def method_missing(method_name, *attrs, &block)
      if self.class.check_blocks.keys.include?(method_name.to_s.gsub('=','').to_sym)
        self.assign_with_check method_name.to_s.gsub('=','').to_sym, attrs.first
      else
        super(method_name, *attrs, &block)
      end
    end
  end
end
