class Michal
  def best_path(triangle)
    #tri = triangle.split(/\s/).map(&:strip).reject(&:empty?).map(&:to_i)
    tri = triangle.sub(/^\n/,'').split(/[^\d\-]+/).map(&:to_i)
    #tri = triangle.scan(/-?\d+/).map(&:to_i)

    sum = 0
    height = 0
    while sum < tri.length 
      height += 1
      sum = (height+1) * height / 2
    end
    (height-1).downto(1) do |level|
      first = (level+1) * level / 2
      (0...level).each do |i|
        left = tri[first+i]
        right = tri[first+i+1]
        tri[first-level+i] += left > right ? left : right
      end
    end
    tri[0]
  end
end
