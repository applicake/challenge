class Bundu
  
  def initialize
    @findings = {}
  end
  
  def count_occurences(ss, len)
    index, count = -len, 0
    while (index = @string.index(ss, index + len))
      count += 1
    end
    count
  end
  
  def fetch_substring(string)
    @string = string
    @string_size = @string.size
    @string_size.times do |start_point|
      2.upto(@string_size - start_point) do |length|
       chunk = @string.slice(start_point, length)
       next if @findings[chunk]
       match_count = count_occurences(chunk, length)
       break if match_count < 2       
       @findings[chunk] = { :occurences => match_count, :length => length }
      end
    end
    return '' unless @findings.size > 0
    @findings = @findings.sort_by {|x| [x[1][:length], x[1][:occurences]] }.reverse
    max_length, max_count = @findings.first[1][:length], @findings.first[1][:occurences]
    @findings.reject! { |arr| arr[1][:length] < max_length or  arr[1][:occurences] < max_count }
    @findings.collect! { |arr| arr[0] }
    @findings.sort.join(' ')
  end
  
end