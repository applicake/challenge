class Kiszal
  attr_accessor :line
  
  def initialize 
    self.line = {}
  end 
  
  def push(object, key)
    raise Exception if self.line[object]
    self.line[object] = key
  end
  
  def min
    min_value, min_key = self.line.min{|a,b| a.last <=> b.last}
    return min_value
  end
  
  def pop
    key = self.min
    self.line.delete(key)
    return key
  end
  
  def decrease_key(object, key)
    self.line[object] < key ? (raise Exception) : self.line[object] = key
  end
end