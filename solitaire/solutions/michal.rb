require 'stringio'

class DLLDeck
  attr_reader :a, :b, :ab, :s
  def initialize
    nodes = []
    54.times do
      nodes << DLLNode.new
    end
    nodes << DLLNode.new

    54.times do |i|
      nodes[i].n = nodes[(i + 1)%54]
      nodes[i].p = nodes[(i + 54 -1 )%54]
    end
    @s = nodes[0]
   # @b = nodes[53]
    #@a = nodes[52]
    #@ab = true
    #reset
  end

  def reset
    pos = @s
    (1..53).each do |v|
      pos.v = v
      pos = pos.n
    end
    pos.v = 53
    @b = @s.p
    @a = @b.p
@ab = true    
  end
  
  def p
    pos = @s
    result = (1..54).map do 
      r = value(pos)
      if pos == @b
        r = "B#{r}"
      elsif pos == @a
        r = "A#{r}"
      end  
      pos = pos.n
      r
    end.join(',') + ' ' + @ab.to_s
    puts result
    pos = @s.p
    result = (1..54).map do 
      r = value(pos)
      if pos == @b
        r = "B#{r}"
      elsif pos == @a
        r = "A#{r}"
      end  
      pos = pos.p
      r
    end.reverse.join(',') + ' ' + @ab.to_s
    puts result

  end

  def a_down1
    @ab = !@ab if @b == @a.n
    @ab = !@ab if @s == @a.n
    move(@a, @a.n)
    @s = @a.p if @s == @a
  end

  def b_down2
    @ab = !@ab if @a == @b.n || @a == @b.n.n
    @ab = !@ab if @s == @b.n || @s == @b.n.n
    move(@b, @b.n.n)
    @s = @b.p.p if @s == @b
  end

  def triple_cut
    if @ab
      x, y = @a, @b
    else
      x, y = @b, @a
    end
    if x != @s && y != @s.p  
      
      l_s = @s
      l_e = x.p
      r_s = y.n
      r_e = @s.p

      #l_s.p, y.n,   r_e.n, x.p,   r_s.p, l_e.n,  @s   =   y, l_s,   x, r_e,   l_e, r_s,   r_s 
      l_s.p = y  
      y.n   = l_s
      r_e.n = x  
      x.p   = r_e
      r_s.p = l_e
      l_e.n = r_s
      @s    = r_s
    elsif x != @s
    #  s = @s
    #  s.p = y
    #  y.n = s
      @s  = x
    elsif y != @s.p
       #r_s = y.n
    #   r_e = @s.p
     #  s = @s
       
      # r_e.n =  @s
       #s.p   =  r_e
      @s    =  y.n#r_s
       
       #r_e.n, s.p,   @s   =   s, r_e,  r_s 
       
        
    end 
  end

  def fetch_card
    count = @s.v
    pos = @s
    if count <= 26
      count.times do
        pos = pos.n
      end
    else
      (54 - count).times do
        pos = pos.p
      end
    end
    pos.v
  end

  def round
    card = 53
    until card < 53
      a_down1
      b_down2
      triple_cut
      count_cut

      card = fetch_card
    end
    card
  end

  def count_cut
    count = @s.p.v
     
    if count < 26
      pos = @s.p
      count.times do
        pos = pos.n
        @ab = !@ab if @a == pos
        @ab = !@ab if @b == pos
      end
    elsif count < 53
      pos = @s.p.p
      (53-count).times do
        @ab = !@ab if @a == pos
        @ab = !@ab if @b == pos
        pos = pos.p
      end
    else
      return
    end
      s = @s
      e = @s.p
      new_s = pos.n
      before_last = s.p.p
      s.p, before_last.n, pos.n, e.p,      new_s.p, e.n,       @s    = before_last, s,  e, pos,      e,    new_s,    new_s
    
  end

  def value(pos)
    pos.v
  end

  def move(node, pos)
#    insert(to, remove(from))

    r = node
    node.p.n = node.n
    node.n.p = node.p
    r.p = pos
    r.n = pos.n    
    pos.n.p = r
    pos.n = r
  end

  def remove(node)
    r = node
    node.p.n = node.n
    node.n.p = node.p
    r
  end

  def insert(pos, node)
    node.p = pos
    node.n = pos.n    
    pos.n.p = node
    pos.n = node
  end

private 
  class DLLNode
    
    attr_accessor :p, :n, :v
    #def initialize(v)
    #  self.v = v
    #end
  end
end
class Michal
  def initialize
    @deck = DLLDeck.new
  end

  def encrypt(message)
    @deck.reset
    #@deck = DLLDeck.new
    #m = StringIO.new(message) 
    n = StringIO.new
    i = 0
    
    message.each_byte do |c|
      c -= 32 if c >= 97 && c <= 122 
      next if c < 65 || c > 90
      if (i == 5)  #c == 32
        i = 0
        n.putc(32)
      end
      n.putc( (c - 65 + @deck.round) % 26 + 65)
      i += 1 
    end
    (5-i).times { n.putc((23 + @deck.round) % 26 + 65) }
    #n.truncate(n.pos)
    n.string 
  end

  def decrypt(message)
    @deck.reset
#reset_deck
    m = StringIO.new(message)
    #@deck = DLLDeck.new

    i = 0
    message.each_byte do |c|
      #if c == 32
      if ((i+=1) == 6)  #c == 32
        i = 0
        m.putc(32)
      else
        m.putc((c - 39 - @deck.round) % 26 + 65)
      end
    end
    m.string
  end


 end