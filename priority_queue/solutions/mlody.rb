#########################################
# Ruby implementation of priority queue #
#     based on Fibonacci's Heaps        #
#########################################


class Mlody
  private

  # element structure of node implementation
  class Node
    attr_accessor :parent, :child, :left, :right, :value, :key, :degree, :mark

    def initialize(value, key)
      @degree = 0
      @key = key
      @value = value
    end

    # setting child in empty place
    def child=(c)
      raise "Child of self" if c == self
      raise "Neighbour child" if (c == self.right) or (c == self.left)
      @child = c
    end
  end


  def link_nodes(node1, node2)
    return link_nodes(node2, node1) if node2.key < node1.key

    node2.parent = node1
    child = node1.child
    node1.child = node2

    if child
      node2.left = child.left
      node2.left.right = node2
      node2.right = child
      child.left = node2
    else
      node2.left = node2
      node2.right = node2
    end

    node1.degree += 1
    node2.mark = false
    node1
  end

  def delete_first
    return nil unless @rootlist

    result = @rootlist

    if result == result.right
      @min = @rootlist = nil
    else
      @rootlist = result.right
      @rootlist.left = result.left
      @rootlist.left.right = @rootlist
      result.right = result.left = result
    end

    return result
  end

  def cut_node(n)
    return self unless n.parent

    n.parent.degree -= 1
    
    if n.parent.degree == n
      (n.right == n) ? (n.parent.child = nil) : (n.parent.child = n.right)
    end
    n.parent = nil
    n.right.left = n.left
    n.left.right = n.right

    n.right = @rootlist
    n.left = @rootlist.left
    @rootlist.left.right = n
    @rootlist.left = n

    n.mark = false

    return self
  end

  def insert_tree(tree)
    if @rootlist == nil
      @rootlist = @min = tree
    else
      l = @rootlist.left
      l.right = tree
      @rootlist.left = tree
      tree.left = l
      tree.right = @rootlist
      @min = tree if tree.key < @min.key
    end
    self
  end

  def fortify
    return self if self.empty?
    arr_size = (2.0 * Math.log(self.length) / Math.log(2) + 1.00).ceil
    degree_tree = Array.new(arr_size)

    while node1 = delete_first
      while node2 = degree_tree[node1.degree]
        degree_tree[node1.degree] = nil
        node1 = link_nodes(node1, node2)
      end
      degree_tree[node1.degree] = node1
    end

    @rootlist = @min = nil
    degree_tree.each do |tree|
      next unless tree
      insert_tree(tree)
    end
    self
  end

  public

  attr_reader :length

  # new empty priority queue
  def initialize
    @nodes = Hash.new
    @rootlist = nil
    @min = nil
    @length = 0
  end

  def decrease_key(value, key)
    return push(value, key) unless @nodes[value]

    node = @nodes[value]
    raise "Higher index" if node.key < key


    node.key = key
    @min = node if node.key < @min.key

    return self if !node.parent or node.parent.key <= node.key
    # cuting one after another
    begin
      par = node.parent
      cut_node(node)
      node = par
    end while n.mark and n.parent
    node.mark = true if n.parent
    
    self
  end

  def push(value, key)
    #return decrease_key(value, key) if @nodes[value]
    raise "Not unique value" if @nodes[value]
    @nodes[value] = node = Node.new(value, key)
    @min = node if !@min or key < @min.key

    unless @rootlist
      @rootlist = node
      node.left = node.right = node
    else
      node.left = @rootlist.left
      node.right = @rootlist
      @rootlist.left.right = node
      @rootlist.left = node
    end
    @length += 1
    
    self
  end

  def empty?
    @rootlist.nil?
  end

  def min
    @min.value rescue nil
  end

  def delete(value)

    return nil unless node = @nodes.delete(value)

    if node.child
      child1 = node.child
      child2 = node.child
      begin
        rght = child1.right
        cut_node(child1)
        child1 = rght
      end while child1 != child2
    end
    cut_node(node) if node.parent

    if node == node.right
      @min = nil
      @rootlist = nil
    else
      @rootlist = node.right if @rootlist == node
      if @min == node
        node1 = node.right
        @min = node1
        begin
          @min = node1 if node1.key < @min.key
          node1 = node1.right
        end while(node1 != node)
      end
      node.right.left = node.left
      node.left.right = node.right
      node.left = node
      node.right = node
    end
    @length -= 1 if @length

    return [node.value, node.key]

  end

  def pop
    return nil if self.empty?
    result = self.min

    @nodes.delete(@min.key)

    if @length == 1
      @rootlist = @min = nil
      @length = 0
    else
      min = @min
      if @min == @rootlist
        if @rootlist == @rootlist.right
          @rootlist = @min = nil
        else
          @rootlist = @min = @min.right
        end
      end

      min.left.right = min.right
      min.right.left = min.left
      min.left = min.right = min

      if min.child
        node = min.child
        begin
          node.parent = nil
          node.mark = false
          node = node.right
        end while node != min.child

        if @rootlist
          l1 = @rootlist.left
          l2 = node.left

          l1.right = node
          node.left = l1
          l2.right = @rootlist
          @rootlist = l2
        else
          @rootlist = node
        end
      end

      @length -= 1
      fortify
    end

    result
  end

end
