class Solution

  Node = Struct.new("Node", :parent, :coin, :total, :c_index)

  def change(money, coins)
    root = Node.new(nil, nil, 0, 0)
    found = { 0 => root }
    queue = [root]
    total = 0
    
    until total == money or queue.empty?
      node = queue.shift
      
      node.c_index.upto(coins.size - 1) do |index|
        coin = coins[index]
        total = node.total + coin
        next if total > money || found[total]  # prune
        new_node = Node.new(node, coin, total, index)
        found[total] = new_node
        queue << new_node
      end
    end

    return [] if found[money].nil?  # no solution found

    result = []
    cursor = found[money]
    until cursor.coin.nil?
      result << cursor.coin
      cursor = cursor.parent
    end
    result
  end

end