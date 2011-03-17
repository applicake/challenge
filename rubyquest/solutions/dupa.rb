class Dupa

  def initialize(label, nodes=[])
    @label = label
    @nodes = nodes
  end

  def trip
    result = []
    result << @label
    current_node = @nodes.shift
    while current_node
      result << current_node.trip
      current_node = @nodes.shift
    end
    return result.flatten
  end
end
