class Matt

  def resolve(gems)
    output = []
    size = gems.size
    until size <= output.size
      temp_output = []
      raise "Input data is incorrect" if !gems.reject! do |gem, dependency| 
        if dependency.empty?
          temp_output << gem
          true
        end
      end
      
      gems.each_pair do |dgem,ddependency|
         gems[dgem] = ddependency.delete_if {|ddep| temp_output.include?(ddep)}

      end
      output.concat temp_output

    end
    output

  end

end