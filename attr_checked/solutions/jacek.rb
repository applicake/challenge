module Jacek
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def jacek_attr_checked(name, &block)
      unless block_given?
        raise Exception.new('You\'ve got to specify a validation block fool!')
      end
      attr_accessor name
      alias_method :simple_assign=, "#{name}=".to_sym
      define_method "#{name}=".to_sym do |value|
        if block.call(value)
          self.simple_assign = value
        else
          raise "Attribute not valid" 
        end
      end
    end
  end
end



