module MarcinO
  def marcin_o_slice(arg = nil)

    result = []
    last = 0

    self.each_index do |i|      
      if block_given?
        condition = yield self[i]
      else
        condition = self[i] == arg
      end

      if condition
        result << self[last...i]
        last = i + 1         
      end
    end
    result << self[last..self.length]     

#puts result.inspect

  end
end

Array.send :include,  MarcinO
