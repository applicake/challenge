class Bundu
  
  def resolve(gems)
    @gemlist, @result, @remaining = gems, [], []
    @gemlist.reject! { |key, item| @result.push(key) if item.empty? }
    for name in @gemlist.keys
      resolve_gem(name) if @gemlist.include?(name) 
    end
    @result
  end
  
  def resolve_gem(gem_name, parents = {})
    dependencies = @gemlist.delete(gem_name)
    parents.store(gem_name, true)
    for dep in dependencies
      if parents.include?(dep)     then raise
      elsif @gemlist.include?(dep) then resolve_gem(dep, parents)   
      end
    end
    parents.delete(gem_name)
    @result.push gem_name 
  end
  
end