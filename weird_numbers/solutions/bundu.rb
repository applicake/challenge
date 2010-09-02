class Bundu

  def fetch_less_then(max)
    # http://en.wikipedia.org/wiki/Weird_number
    # It is not known if any odd weird numbers exist; if any do, they must be greater than 23 ** 2 ≈ 4 × 10 ** 9
    candidate = 2
    result = []
    # http://en.wikipedia.org/wiki/Semiperfect_number
    # "every multiple of a semiperfect number is semiperfect"
    # we store all the pseudoperfects we found so far 
    # and check whether any of the divisors are pseudoperfect
    # The hash is used for speed
    @known_pseudoperfects = {}
    while candidate <= max
      # find all the factors and the sum of all factors
      divisors, sum = factors(candidate)
      # check if number is abundant and check for pseudoperfection
      if sum > candidate and !pseudoperfect?(candidate, divisors)
        result << candidate
      end
      # Weird numbers are even, do not check for odds, hence the +2
      candidate += 2
    end
    result 
  end
  
  # Check if a number is pseudoperfect
  def pseudoperfect?(candidate, divisors)
    divisors.each { |d| return true if @known_pseudoperfects[d] }
    # This uses the meet-in-the-middle subset sum algorithm
    # It is modified to store known pseudoperfects
    half = divisors.length/2
    part_one = divisors[0, half]
    part_two = divisors[half, half + 1]
    sums = {}
    subsets(part_one) { |subset| sums[self.sum(subset)] = true }
    subsets(part_two) do |subset| 
      if sums[candidate - self.sum(subset)]
        @known_pseudoperfects[candidate] = true
        return true 
      end
    end
    false
  end
    
  def subsets(array)
    # Use a queue instead of recursion to be able to handle long arrays
    # and so that Kiszal won't try to break it by picking some insane number
    # and laugh in my face when it crashes. I really want to avoid that :)
    queue = [[array,0]]
    while combination = queue.shift
      ar = combination[0]
      yield(ar) 
      len = ar.length
      (len-1).downto(combination[1]) do |i|
        slice = ar[0, i] 
        # if i+1 is within the last index, then merge (this allows us to skip a few merges)
        if i+1 < len
          slice += ar[i+1, (len - i)]
        end
        queue.push([slice,i])
      end
    end
  end
  
  # Sum the number elements of the array
  def sum(array)
    array.inject( 0 ) { |sum,x| sum ? sum+x : x }; 
  end
  
  # Calculate all the factors of a number
  def factors(number)
    sum = 1
    # Every number is divisible by 1, so it will be in every result
    result = [1]
    2.upto(Math.sqrt(number)) do |n|
      quotient, remainder = number.divmod(n)
      if remainder == 0
        if n == quotient
          result << n
          sum += n
          break
        else
          result << quotient << n
          sum += n += quotient
        end
      end
    end
    [result, sum]
  end
 
end
