class Tree < Struct.new(:node_name, :children)
  
  
  def trip
    result = []
    result << self.node_name
    if self.children
      result += self.children.map { |c| c.trip }.flatten.compact
    end
    result
  end
end
