class Kiszal 
  attr_accessor :no_lines, :first_line, :countries, :sum
 
  def initialize
    @countries =  IO.readlines("IpToCountry.csv")
    @no_lines =  @countries.nitems - 1
    
    @first_line = 0 # first line when there are actual numbers - can be found manually every time
    @sum = 0
  end 
  def find_country_by_ip(ip)

    ip.split('.').each_with_index do |number, index|
      @sum = @sum +  256**(3-index)* number.to_i
    end
    binary_search(@sum)
  end

  def binary_search( target)
    search_iter(@first_line, @no_lines , target)
  end
  
  def search_iter( lower, upper, target)
    return -1 if lower > upper
    mid = (lower+upper)/2
    record = @countries[mid].split(',')
    if (target  >= record[0][1..-2].to_i and target <= record[1][1..-2].to_i)
      return record[4][1..-2]
    elsif (target < record[0][1..-2].to_i)
      search_iter(lower, mid-1, target)
    else
      search_iter(mid+1, upper, target)
    end
  end    
end


#class Kiszal
#  def find_country_by_ip(ip)
#    sum = 0
#    ip.split('.').each_with_index do |number, index|
#      sum = sum +  256**(3-index)* number.to_i
#    end
#    file = File.open('IpToCountry.csv', 'r')
#    file.each do |row|
#      next if row[0].chr =="#" 
#      record = row.split(',')
#      if sum >= record[0][1..-2].to_i and sum <= record[1][1..-2].to_i
#        return record[4][1..-2]
#      end
#    end 
#  end
#end
