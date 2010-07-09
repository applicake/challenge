module Dawid
 def dawid_slice(item=nil, &block)
   arr = self.clone
   ret = []
   self.each do |i|
     if (item and i==item) or (block_given? and block.call(i))
       ret << arr.slice!(0,arr.index(i)+1)[0..-2]
     end
   end
   ret << arr
   ret
 end
end

Array.send :include, Dawid