class Kiszal
  def no_more_nodes?
    @gems.empty?
  end  
  
  def get_leaf
    @leafs.pop
  end 
   
  def remove_from_dependencies(leaf)
    if @reverse_gems[leaf]
      @reverse_gems[leaf].each do |r| 
        @gems[r].delete(leaf) 
        @leafs << r if @gems[r].empty?
      end 
    end 
    @gems.delete(leaf)
  end 

  def resolve(gems)
    @gems = gems
    @result = []
    @reverse_gems = {}
    @leafs = []

    @gems.each_pair do |key, value|
      @leafs << key if value.empty?
      value.each do |val|
        @reverse_gems[val] ||= [] 
        @reverse_gems[val] << key
      end 
    end 
    
    while (leaf_key = get_leaf) != nil   
      remove_from_dependencies(leaf_key) 
      @result << leaf_key 
    end 
     
    if self.no_more_nodes?
      return @result 
    else 
      raise 'Exception' 
    end
  end 
end

