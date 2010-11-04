class Michal
  
  def initialize
    @container = []
    @min = nil
  end
  def push(object, key)
    raise "Object exists" if @container.find { |x| x.first == object }
    @container << [object, key]
    @min = nil
  end
  
  def min
    unless @min
      result = @container.min { |a,b| a.last <=> b.last }
      @min = result && result.first
    end
    @min 
  end
  
  def pop
    found = @container.min { |a,b| a.last <=> b.last }
    return nil unless found
    deleted = @container.delete(found)
    @min = nil
    deleted.first
  end
  
  def decrease_key(object, key)
    found = @container.find { |x| x.first == object }
    raise "Tried to increase" if found[1] < key
    if found
      found[1] = key
    end
    @min = nil
  end
end
