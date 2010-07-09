module Dawidsklodowski
  def self.included(mod)
    mod.extend(ClassMethods)
  end
  
  module ClassMethods
    def dawidsklodowski_attr_checked (*args, &block)
      args.each do |arg|
        class_eval do
          define_method arg.to_s+'=' do |v|
            if block.call(v)
              instance_variable_set('@'+arg.to_s, v)
            else
              raise 'Exception!'
            end
          end
          define_method arg.to_s do
            instance_variable_get('@'+arg.to_s)
          end  
        end
      end  
    end
  end
end


