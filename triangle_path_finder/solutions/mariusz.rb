class Mariusz
  
  def best_path(triangle)
    nodes = triangle.scan(/-?\d+/)
    prev_row = [0]
    row = []
    row_node = 0
    row_nodes = 1
    for node in nodes
      if row_node == row_nodes - 1
        row << (prev_row.last + node.to_i)
        prev_row = row
        row_node = 0
        row_nodes += 1
      elsif row_node == 0
        row = [prev_row.first + node.to_i]
        row_node += 1
      else  
        parent1, parent2 = prev_row[row_node - 1, 2]
        row << ((parent1 > parent2 ? parent1 : parent2) + node.to_i)
        row_node += 1
      end
    end
    row.max
  end
  
end