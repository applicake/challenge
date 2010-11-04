class Agata

  def initialize
    @queue = Hash.new{ [ ] }
  end

  def push(value, key)
    unless @queue.values.include?([value])
      @queue[key] = @queue[key] << value 
    else
      raise 'an error has occurred'
    end   
  end
 
  def min
    return nil if @queue.empty?
    key, val = @queue.min
    return val.first
  end
  
  def pop
    return nil if @queue.empty?
    key, val = @queue.min
    result = val.first
    if val.empty? || val.nitems == 1
      @queue.delete(key)
    else
      val.shift
    end
    return result
  end
  
  def decrease_key(object, key)
   if @queue.has_value?([object])
     old_key = @queue.index([object])
     unless old_key < key
       @queue[key] = @queue[key] << object
       @queue.delete(old_key)
     else
      raise 'an error has occurred'
     end
   end
  end
  
end
