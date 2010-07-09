module Jozef 
  def self.included(base)
    base.extend ExtraClassMethods
  end

  module ExtraClassMethods
    def jozef_attr_checked(name, &blk)
      if block_given?
        define_method :"#{name}=" do |value|
          if blk.call(value)
            instance_variable_set("@#{name}",value) 
          else
            raise "Attr Validation Error!"
          end
        end
    
        define_method :"#{name}" do 
          instance_variable_get("@#{name}")
        end
      else
        attr_accessor name
      end
    end
  end
end
