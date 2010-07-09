# Ugly like hell, also fast like hell :)
module BunduFast
  def bundu_fast_slice(value = nil, &block)
    if block_given?
      result, tmp = [], []
      each do |item|
        if block.call(item)
          result << tmp
          tmp = []
        else
          tmp << item
        end
      end
      result << tmp
    else
      return [self] if value == nil
      result, tmp = [], []
      each do |item|
        if value == item
          result << tmp
          tmp = []
        else
          tmp << item
        end
      end
      result << tmp
    end
  end
end

Array.send :include, BunduFast