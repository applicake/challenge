class IpRange
  attr_accessor :first, :last, :code
end

class Michal 
  def initialize
    path = File.dirname(__FILE__) + "/../IpToCountry.csv"
    @ip_ranges = []
    IO.foreach(path) do |line|
      next unless line[0] == 34 # ascii of "
      range = IpRange.new
      values = line.split(',')
      range.first = values[0][1..-2].to_i
      range.last = values[1][1..-2].to_i
      range.code = values[4][1..-2]
      @ip_ranges << range
    end
    
      
  end

  def find_country_by_ip(ip)
    integer_ip = ip_to_integer(ip)
    lower, upper = 0, @ip_ranges.length - 1
    while(upper >= lower) do
      idx = lower + (upper - lower) / 2
      if @ip_ranges[idx].first > integer_ip
        upper = idx - 1
      elsif @ip_ranges[idx].last < integer_ip
        lower = idx + 1
      else 
        return @ip_ranges[idx].code
      end
    end
  end

  def ip_to_integer(ip)
    ip.split('.').inject(0) {|total,value| (total << 8 ) + value.to_i}
  end
end
