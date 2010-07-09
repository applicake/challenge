module InheritanceFix 
  def self.included(base)
    def base.inherited(subclass)
      superclass_checked_attrs =  subclass.superclass.instance_variable_get('@checked_attributes').dup
      subclass.instance_variable_set('@checked_attributes', superclass_checked_attrs)
    end
  end 
end 

