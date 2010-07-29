class Jozef
  SIZE_HTable = 16777215

  def initialize
    @h_array = []
    @total = 0
  end

  def store(key, value)
    index = skunzize(key)
    @total += 1 if @h_array[index].nil?
    @h_array[index] = value
  end
  
  def fetch(key)
    index = skunzize(key)
    value = @h_array[index]
    raise if value.nil?
    value
  end           
   
  def delete(key)
    index = skunzize(key)
    raise if @h_array[index].nil?
    @total -= 1
    @h_array[index] = nil
  end       
   
  def has_key?(key)
    index = skunzize(key)
    if @h_array[index] then true else false end
  end         
  
  def length
    @total
  end

  private

  def skunzize(key)
    h = key[0]; i = 1
    while !key[i].nil? do
      h = (h << 4) + key[i]; i+= 1
    end
    h.modulo(SIZE_HTable)
  end
end
