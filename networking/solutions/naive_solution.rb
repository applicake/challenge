class Graph

	# Constructor

	def initialize
		@g = {}	 # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
		@nodes = Array.new		 
		@INFINITY = 1 << 64 	 
	end
		
	def add_edge(s,t,w) 		# s= source, t= target, w= weight
		if (not @g.has_key?(s))	 
			@g[s] = {t=>w}		 
		else
			@g[s][t] = w         
		end
		
		# Begin code for non directed graph (inserts the other edge too)
		
		if (not @g.has_key?(t))
			@g[t] = {s=>w}
		else
			@g[t][s] = w
		end

		# End code for non directed graph (ie. deleteme if you want it directed)

		if (not @nodes.include?(s))	
			@nodes << s
		end
		if (not @nodes.include?(t))
			@nodes << t
		end	
	end

  def remove_edge(s, t)
    if @g.has_key?(s)
      if @g[s].has_key?(t)
        @g[s].delete t
      end
    end
    if @g.has_key?(t)
      if @g[t].has_key?(s)
        @g[t].delete s
      end
    end
  end
	
	# based of wikipedia's pseudocode: http://en.wikipedia.org/wiki/Dijkstra's_algorithm
	
	def dijkstra(s)
		@d = {}
		@prev = {}

		@nodes.each do |i|
			@d[i] = @INFINITY
			@prev[i] = -1
		end	

		@d[s] = 0
		q = @nodes.compact
		while (q.size > 0)
			u = nil;
			q.each do |min|
				if (not u) or (@d[min] and @d[min] < @d[u])
					u = min
				end
			end
			if (@d[u] == @INFINITY)
				break
			end
			q = q - [u]
			@g[u].keys.each do |v|
				alt = @d[u] + @g[u][v]
				if (alt < @d[v])
					@d[v] = alt
					@prev[v]  = u
				end
			end
		end
	end
	
  def has_node?(x)
    @g.has_key?(x)
  end
	# To print the full shortest route to a node
	
	def print_path(dest)

		return [dest] unless @prev[dest] != -1
		print_path(@prev[dest]) + [dest]
	end
	
	# Gets all shortests paths using dijkstra
	
	def shortest_paths(s)
		@source = s
		dijkstra s
		puts "Source: #{@source}"
		@nodes.each do |dest|
			puts "\nTarget: #{dest}"
			print_path dest
			if @d[dest] != @INFINITY
				puts "\nDistance: #{@d[dest]}"
			else
				puts "\nNO PATH"
			end
		end
	end
end


class NaiveSolution
  def initialize
   @g = Graph.new
  end
  def add_friendship(first, second)
    @g.add_edge(first, second, 1)
  end

  def remove_friendship(first, second)
    @g.remove_edge(first, second)
  end
  
  def shortest_path(source, target)
    return [] unless @g.has_node?(source) and @g.has_node?(source) 
    @g.dijkstra(source)
    path = @g.print_path(target)
    path = [] if path.length < 2
    path
  end


end


