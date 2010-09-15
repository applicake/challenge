class Mysolution

  def fetch_matching_comb(array, int)
    current = {
      0 => [{ :components => [], :remaining_numbers => array.sort.reverse }]
    }
    result = []
    while !current.empty?
      previous = current
      current = {}
      previous.keys.sort.reverse.each do |previous_sum|
        previous[previous_sum].each do |data|
          data[:remaining_numbers].each do |number|
            new_sum = previous_sum + number
            current[new_sum] = [] unless current.has_key? new_sum
            current[new_sum] << { :components =>  [number] + data[:components], :remaining_numbers => data[:remaining_numbers] - [number] }
          end
        end     
      end
      if current.has_key? int
        current_components = []
        current[int].each do |data|
        #  datas.each do |data|
            current_components << data[:components]
         # end
        end 
        result += current_components#.reverse
      end
    end
    result.reverse
  end
end
