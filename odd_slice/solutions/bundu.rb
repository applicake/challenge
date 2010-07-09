module Bundu
  def bundu_slice(value = nil, &block)
    result, tmp = [], []
    each do |item|
      if (value and value == item) or (block and block.call(item))
        result << tmp
        tmp = []
      else
        tmp << item
      end
    end
    result << tmp
  end
end

Array.send :include, Bundu