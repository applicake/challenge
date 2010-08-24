class Jozef
  SIZE_HTable = 8388607

  def initialize
    @h_array = []
    @total = 0
  end

  def store(key, value)
    index = skunzize(key)
    @h_array[index] ||= []

    r = find_pair(index, key)
    if !r or r.empty?
      @h_array[index] << [key, value]
      @total += 1
    else
      @h_array[index].each do |e| e[1] = value if e.first == key end
    end
  end
  
  def fetch(key)
    index = skunzize(key)
    r = find_pair(index, key)
    raise if !r or r.empty?
    r.first.last
  end           
   
  def delete(key)
    index = skunzize(key)
    r = find_pair(index, key)
    raise if !r or r.empty?
    @total -= 1
    @h_array[index].delete_if do |e| e.first == key end
  end       
   
  def has_key?(key)
    index = skunzize(key)
    r = find_pair(index, key)
    if !r then false else true end
  end         
  
  def length
    @total
  end

  def find_pair(index, key)
    pair = @h_array[index]
    return false if (pair.nil? or pair.empty?)
    pair.select do |e| e.first == key end
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
