class Dominik
  def initialize
    @keys = []
    @values = []
  end
  
  def store(key, value)
    if index  = @keys.index(key)
      @values[index] = value
    else
      @keys << key
      @values << value
    end
  end
  
  def fetch(key)
    @values.at(@keys.index(key))
  end           
   
  def delete(key)
    index = @keys.index(key)
    @values.delete_at(index)
    @keys.delete_at(index)
  end       
   
  def has_key?(key)
    if @keys.index(key)
      true
    else
      false
    end
  end         
  
  def length
    @values.size
  end
end
