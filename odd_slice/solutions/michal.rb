module Michal                
  # we can have problem with nil when doing things like [1, nil, 2].odd_slice 
  # but lets not worry about that now and clarify it with client later 
  # we should clarify as well what should happen when someone calls odd_slice(3) {|a| a == 2}
  def michal_slice(divider = nil, &block)
    slices = []
    right_slice = self.clone
    until right_slice.empty?
      divider_found = false
      left_slice, right_slice = right_slice.partition do |element| 
        divider_found |= (block && block.call(element)) || (element == divider)
        !divider_found
      end
      slices << left_slice  
      return slices if right_slice.empty? 
      right_slice.shift
    end
    
    slices << right_slice
  end
end

Array.send :include, Michal