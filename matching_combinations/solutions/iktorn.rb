class Iktorn
  def fetch_matching_comb(array, int)
    array.sort.inject([[]]) { |ps,item|
      ps + ps.map{ |e| e + [item] if e.sum + item <= int }.compact
    }.find_all{|a| a.sum == int}.inject([]){|s,a| s += a.permutation.to_a}.ssort.reverse
  end
end

class Array
  def ssort
    self.sort {|a,b| (a <=> b if a.size == b.size) || a.size <=> b.size} # strange sort ;>
  end
  
  def sum
    self.inject(0){|s,i| s+=i}
  end
end