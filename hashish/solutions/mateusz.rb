class Mateusz

  def initialize
    @keys = []
    @values = []
  end

  def store(key, value)
    position = @keys.index(key)
    if position.nil?
      @keys << key
      @values << value
    else
      @values[position] = value
    end
  end
  
  def fetch(key)
    position = @keys.index(key)
    raise StandardError if position.nil?
    @values.fetch(position)
  end           
   
  def delete(key)
    position = @keys.index(key)
    raise StandardError if position.nil?
    @keys.delete_at position
    @values.delete_at position
  end       
   
  def has_key?(key)
    !@keys.index(key).nil?
  end         
  
  def length
    @keys.length
  end
end

