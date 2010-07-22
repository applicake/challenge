class Jacek
  def resolve(gems)
    JaceksResolver.new(gems).resolve
  end
end

class JaceksResolver
  attr_reader :gems, :gem_hash, :gem_hash_mapped, :gem_tables, :result, :sorted_gem_tables, :sorted_gem_tables_with_includes

  def initialize(gem_hash)
    @gem_hash = gem_hash
    @gems = gem_hash.keys
    @gem_count = @gems.nitems
    @gem_hash_mapped= @gem_hash.inject({}) {|sum, k| sum.merge({@gems.index(k[0]) => k[1].collect{|x| @gems.index(x)}})}
    @gem_tables = @gem_hash_mapped.inject([]) {|sum, k| sum << k.flatten.uniq}
    @gem_tables_with_includes = @gem_tables.collect do |arr|
      begin
        required = @gem_hash_mapped.values_at(*arr).flatten.uniq.compact - arr
        arr += required
      end until(required.empty?) 
      arr
    end
    resolve
  end

  def resolve
    @sorted_gem_tables_with_includes = @gem_tables_with_includes.sort {|x,y| x_i_y = x.include?(y.first); y_i_x = y.include?(x.first); x_i_y ? (y_i_x ? (raise self.exception) : 1) : (y_i_x ? -1 : 0)}
    @result = @sorted_gem_tables_with_includes.collect {|x| @gems[x.first]}
  end

  def exception
    Exception.new 'Loop found!'
  end

end
