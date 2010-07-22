class Joseph
  def resolve(gems)
    @gems, @no_dep_gems = [], []
    gems.each {|key,arr| check_array(arr, gems, key)}
    @no_dep_gems.concat(@gems).concat(gems.keys)
  end

  private

  def check_array(arr, gems, key)
    if arr.empty?
      @no_dep_gems.push(key)
      gems.delete(key)
    else
      arr.each do |e|
        if gems[e]
          if gems[e].empty?
            @no_dep_gems.push(e)
          else
            check_array(gems[e], gems, e)
            @gems.push(e)
          end
          gems.delete(e)
        end
      end
    end
  end
end
=begin
gems = {
  'Gem-1' => ['Gem-2', 'Gem-3'],
  'Gem-2' => ['Gem-3','Gem-5','Gem-6'],
  'Gem-3' => [],
  'Gem-4' => ['Gem-3','Gem-6','Gem-1'],
  'Gem-5' => [],
  'Gem-6' => []
}

r = Jozeffast.new
r.resolve(gems)
=end

