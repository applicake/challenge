module Mariusz 

  def self.included(base)
    class << base
      def mariusz_attr_checked(name, &block)
        attr_reader name
        define_method "#{name}=" do |v| 
          block[v] ? instance_variable_set("@#{name}".to_sym, v) : raise
        end
      end  
    end
  end

end


