class Mehowte
  
  def resolve(gems)

    @dependencies = gems
    @gems = @dependencies.keys
    final_result_length = @gems.length

    @stack = []
    @result = []
    @result_length = 0
    while @result_length < final_result_length
      gem = @stack.pop || @gems.pop

      if gem.is_a? Array
        g = gem[0]
        @result << g
        @result_length += 1
        @dependencies[g] = true

      else
        dependencies = @dependencies[gem]
        if dependencies.nil?
          raise "Cycle found"
        elsif dependencies != true
          if dependencies.empty?
            @result << gem
            @result_length += 1
            @dependencies[gem] = true
          else
            @stack << [gem]
            @stack.concat(dependencies)
            @dependencies[gem] = nil
          end
        end
      end
    end
    @result
  end

end