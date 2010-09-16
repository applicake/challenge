class Bundu

  # Source: http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/32844
  def permutations(array)
    return [array] if array.size < 2
    result = []
    array.each { |e|       
      permutations(array - [e]).each { |p| 
        result << [e] + p
      } 
    }
    result
  end  
  
  def fetch_matching_comb(array, int)
    result = []
    # reject all numbers in the array greater than the target number, sorting the array first
    # important - if a number <= 0 is present, abort. 0 and negative numbers make this trick unusable
    has_zero = false
    corrected = array.sort!.reject { |e| 
      has_zero = true if e <= 0
      e > int 
    }
    array = corrected unless has_zero
    # if last element is a number which is is equal to target number, extract it. 
    # It's one of the combinations and it cannot combine with any other number
    # Again, abort when zero is present
    result << [array.pop] if !has_zero and array.last == int
    # Find all combinations which have the correct sum and calculate permutations for these combinations
    combinations(array, int).each do |combination|
      result += permutations(combination).reverse
    end
    # Once we have all permutations, sort them properly
    result.sort {|a,b| 
      # cache the size, we might use it again
      size = a.size
      if size != b.size
        b.size <=> size
      else
        result = 0        
        size.times { |n|
          if a[n] != b[n]
            result = b[n] <=> a[n] 
            break
          end
        }
        result
      end
    }
  end

  # Sum the number elements of the array
  def sum(array)
    array.inject( 0 ) { |sum,x| sum+x }; 
  end
  
  # This is the non-recursive, queue-based subset finder method from my solution for weird_numbers
  def combinations(array, candidate)
    queue = [[array,0]]
    result = []
    while combination = queue.shift
      ar = combination[0]
      result.push(ar) if sum(ar) == candidate
      len = ar.length
      (len-1).downto(combination[1]) do |i|
        slice = ar[0, i] + ar[i+1, (len - i)]
        queue.push([slice,i])
      end
    end
    result
  end
  
end
