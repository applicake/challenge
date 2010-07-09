module BunduInherited

  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def inherited(subclass)
      subclass.instance_variable_set('@checked_attributes', @checked_attributes)
      super 
    end
  end

end
