class Mariusz
  
  MOD_VALUE = 701
  BASE_VALUE = 128
  
  def initialize()
    @table = Array.new(MOD_VALUE).map do [] end
    @length = 0
  end
  
  def store(key, value)
    elements = @table[hashing(key)]
    element = elements.select do |e| e.key == key end.first
    if element.nil?
      elements << HashishElement.new(key, value)
      @length += 1
    else
      element.value = value
    end
  end
  
  def fetch(key)
    element = find_element key
    if element.nil? 
      raise 
    else
      element.value
    end
  end           
   
  def delete(key)
    elements = @table[hashing(key)]
    element = nil
    index = -1
    elements.each_with_index do |e, i|
      if e.key == key
        element = e
        index = i
        break
      end
    end
    if element.nil? 
      raise 
    else
      @length -= 1
      elements.delete_at(index).value
    end
  end       
   
  def has_key?(key)
    !!find_element(key)
  end         
  
  def length
    @length
  end
  
  private 
  
    def hashing(string)
      value = 0
      string_length = string.length
      for i in 0...string_length
        value += BASE_VALUE**i * string[string_length - i - 1]
      end
      value - (value / MOD_VALUE) * MOD_VALUE
    end
    
    def find_element(key)
      @table[hashing(key)].select do |e| e.key == key end.first
    end
    
end

class HashishElement

  def initialize(k, v)
    @key = k
    @value = v
  end
  
  def key
    @key
  end
  
  def key=(k)
    @key = k
  end
  
  def value
    @value
  end
  
  def value=(v)
    @value = v
  end
  
end

