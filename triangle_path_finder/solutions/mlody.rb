class Mlody

  def best_path(string)
    @arr = string.split.map! {|e| e.to_i}
    return nil if @arr.empty?
    
    @sum = [@arr.first]
    index, level, count = 1, 2, 0

    while index < @arr.size
     
      # left edge
      if count == 0
        @sum[index] = @arr[index] + @sum[index-level+1]
        count += 1

      # right edge
      elsif count == level - 1
        @sum[index] = @arr[index] + @sum[index-level]
        # jump to next row
        level += 1
        count = 0

      # bottom
      else
        @sum[index] = @arr[index] + max(@sum[index-level], @sum[index-level+1])
        count += 1

      end

      index += 1
    end

    # max from all integers in last triangle row
    @sum[(index - level + 1)..index].max
  end

  def maxx(arr)
    arr.inject(arr.first) {|r,e| r = e if r < e; r}
  end

  def max(x, y)
    x > y ? x : y
  end
end
