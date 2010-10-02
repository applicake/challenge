class Mlody

  def initialize
    @frds = Hash.new
    @dist = Hash.new
  end

  def add_friendship(fir, sec)
    @frds[fir] ? (@frds[fir] << sec if !@frds[fir].include?(sec)) : @frds[fir] = [sec]
    @frds[sec] ? (@frds[sec] << fir if !@frds[sec].include?(sec)) : @frds[sec] = [fir]
  end

  def remove_friendship(fir, sec)
    @frds[fir].delete(sec)
    @frds[sec].delete(fir)
  end

  def generate_pathes(src)
    people = @frds.keys.dup
    arr = people.dup

    @dist[src] = []
    @frds[src].each {|e| @dist[e] = [src, e]}

    infinity = []
    1.upto(people.size+1) {|e| infinity << e}
    (people - @frds[src] - [src]).each {|e| @dist[e] = infinity}

    friends = @frds.dup

    until arr.empty?
      the_smallest = min(@dist, arr)
      arr.delete(the_smallest)
      friends.delete(the_smallest)

      arr.each do |e|
        friends[e].each do |f|
          @dist[f] = @dist[e]+[f] if @dist[f].size > @dist[e].size+1
        end
      end
    end

    @dist.each do |k,v|
      if v == infinity
        @dist[k] = []
      end
    end
  end

  def shortest_path(src, tg)
    return [] if @frds.keys.empty? or (@frds.keys & [src, tg]).empty?
    return [] if src == tg

    generate_pathes(src)

    @dist[tg]
  end

  def min(hash, arr)
    result = arr.first
    arr.each {|e| result = e if hash[e].size < hash[result].size}
    result
  end

end
