module Rails
  def rails_slice(value = nil)
    using_block = block_given?
    inject([[]]) do |results, element|
     if (using_block && yield(element)) || (value == element)
       results << []
     else
       results.last << element
     end
     results
    end
  end
end

Array.send :include, Rails