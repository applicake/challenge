class Dominik
  def resolve(h)
    j = h.size
    result = []
  
    while ele = h.index([]) 
      result << ele
      h.delete(ele)
    end
  
    if result != []
      i = 0
      until h.has_value?([ele]) do
        ele = result[i]
        i += 1
      end
  
      i = 0
      while i < j do
        h.each do |key, value|
          if value[1] == nil and ele == value[0]
            result << key
            h.delete(key)
            h.each_value{|v| v.delete(ele)}
            ele = key
          end
        end
        i += 1 
      end
      return result
    else
      raise "cycle error"
    end
  end
end