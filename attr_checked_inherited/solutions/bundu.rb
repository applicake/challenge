module Bundu
  
  def method_missing(name, *args)
    attribute_name = name.to_s.chop 
    self.class.ancestors.each do |ancestor|
      if (attrs = ancestor.instance_variable_get('@checked_attributes'))
        block = attrs[attribute_name]
        procced(attribute_name, args.first, block)
        return
      end
    end
    super
  end
  
end