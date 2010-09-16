class Mariusz
  
  def fetch_matching_comb(array, int)
    sort(match(array.sort, int, []).inject([]) { |matched, m| matched + m.permutations })
  end
  
  private 
  
    def match(candidates, sum, chosen)
      result = []
      candidates.each_with_index do |candidate, i|
        case candidate <=> sum
        when 1
          return []
        when 0
          return result + [chosen + [candidate]]
        when -1
          matched = match(candidates[i+1..-1], sum - candidate, chosen + [candidate])
          result.concat(matched) unless matched.empty?
        end
      end
      result
    end
    
    def sort(ar)
      ar.sort do |x, y| 
        result = y.length <=> x.length
        if x.length == y.length
          x.each_with_index do |e, i| 
            if e != y[i]
              result = y[i] <=> e  
              break
            end
          end
        end
        result
      end
    end

end

class Array
  
  def permutations
    return [self] if size < 2
    perm = []
    each { |e| (self - [e]).permutations.each { |p| perm << ([e] + p) } }
    perm
  end
  
end