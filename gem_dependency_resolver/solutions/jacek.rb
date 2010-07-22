# FINAL 1
class Jacek
  def resolve(gems)
    JaceksResolver.new(gems).resolve
  end
end

class JaceksResolver
  attr_reader :gems, :gem_hash, :gem_tables, :result, :sorted_gem_tables, :sorted_gem_tables_with_includes

  def initialize(gem_hash)
#    PerfTools::CpuProfiler.start("/home/jacek/dupa_profile") do
  #  t1 = Benchmark.measure do
      @gem_hash = gem_hash
      @gems = gem_hash.keys
      @gem_count = @gems.nitems
   # end
   # t2 = Benchmark.measure do
      map_hash
  #  end
 #   t3 = Benchmark.measure do
      add_includes_to_tables
 #   end
#    t4 = Benchmark.measure do
      resolve
#    end
#    puts t1,t2,t3,t4
#    end
  end

  def map_hash
    @gem_tables = @gem_hash.inject([]) {|sum, k| sum << k.flatten.uniq}
  end

  def add_includes_to_tables
    @gem_tables_with_includes = @gem_tables.collect do |arr|
      required = arr
      begin
        required = @gem_hash.values_at(*required).flatten.uniq.compact - required
        unless (required & arr).empty?
          raise self.exception
        end
        arr += required
      end until(required.empty?) 
      arr
    end
#    @gem_tables_with_includes = @gem_tables
  end

  def resolve
    @sorted_gem_tables_with_includes = @gem_tables_with_includes.sort {|x,y| x_i_y = x.include?(y.first); y_i_x = y.include?(x.first); x_i_y ? (y_i_x ? (raise self.exception) : 1) : (y_i_x ? -1 : 0)}
    @result = @sorted_gem_tables_with_includes.map &:first
  end

  def exception
    Exception.new 'Loop found!'
  end

  def verbose
    puts self.gems.inspect
    puts self.gem_hash.inspect
    puts self.gem_hash_mapped.inspect
    puts self.gem_tables.inspect
    puts self.result.inspect

    puts "--------------------"
    puts self.sorted_gem_tables_with_includes.collect {|t| t.inspect}
    puts "--------------------"
  end

  def to_s
    self.gems.inspect
  end

  def inspect
    self.to_s
  end
end
