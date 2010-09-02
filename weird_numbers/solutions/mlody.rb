#/usr/bin/ruby


class Mlody

  def fetch_less_then(max)
    result = Array.new
  
    ct = 0
    while ct < max
      
      if is_weird?(ct)
        result << ct
      end
      ct += 2
    end
    result
  end
  
  def divisors(int)
    first = [1]; second = []; ct = 2
    while ct*ct <= int
      if int % ct == 0
        first << ct
        temp = int/ct
        second.unshift(temp) if temp != ct
      end
      ct += 1
    end
    first + second
  end
  
  def sum(arr)
    result = 0
    arr.each {|e| result = result+e}
    result
  end
  
  
  def sub_sum_eql(arr, sum, int)
    temp = sum - int
    return false if temp < 0
    return true if arr.include?(temp)
  
    summ = sum(arr.select {|e| e < temp})
    return false if summ < temp
  
    arr.each_with_index do |n, i|
      next if n == 0 or n > temp
      arr[i] = 0
      return true if sub_sum_eql(arr, sum - n, int)
      arr[i] = n
    end
  
    false
  end
  
  
  def is_weird?(int)
    div = divisors(int)
    ar_sum = sum(div)
    
    ar_sum > int and div.size < 16 and !sub_sum_eql(div.reverse, ar_sum, int)
  end
end
