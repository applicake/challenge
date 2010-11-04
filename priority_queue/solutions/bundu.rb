# ML The solution doesn't allow float numbers as keys
require 'digest/sha1'
class Bundu
  
  def initialize
    @queue = []
    @storage = {}
    @size = 0
  end
  
  def push(object, key)
    sha1 = Digest::SHA1.hexdigest(Marshal.dump(object))
    raise 'Duplicate' if (@storage.has_key?(sha1))
    @queue.push "#{padding(key)}-#{sha1}"
    @queue.sort!.reverse!
    @size += 1
    @storage[sha1] = { :object => object, :key => key }
  end
  
  def min
    last = @queue[@size - 1]
    if last 
      @storage[last.split('-')[1]][:object]
    else
      nil
    end
  end
  
  def pop
    last = @queue.pop
    @size -= 1
    if last
      key = last.split('-')[1]
      object = @storage[key][:object]
      @storage.delete(key)
      object
    else
      nil
    end
  end
  
  def decrease_key(object, key)
    sha1 = Digest::SHA1.hexdigest(Marshal.dump(object))
    data = @storage[sha1]
    old_key = data[:key]
    
    if key > old_key
      raise 'New key greater than old' 
    else
      @storage[sha1][:key] = key
      @queue.delete "#{padding(old_key)}-#{sha1}"
      @queue.push "#{padding(key)}-#{sha1}"
      @queue.sort!.reverse!
    end
    key
  end
  
  def padding(key)
    result = []
    (30 - key.to_s.length).times { result << 0 }
    result << key
    result.join('')
  end
  
end