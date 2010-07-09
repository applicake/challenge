module Unknown
 def unknown_slice(num = nil, &block)
   block = proc { |i| i == num } unless block_given?

   val = [[ ]]

   self.each { |i|
     if (block.call(i))
       val.push([])
     else
       val.last.push(i)
     end
   }
   val
 end
end

Array.send :include, Unknown