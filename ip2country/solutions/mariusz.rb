class Mariusz 
  
  BASE = 256
  LINE_SEPARATOR = 10

  # The db file must contain a sorted (ascending) list of ip data in a specific format.
  def initialize
    @db = File.open File.dirname(__FILE__) + "/../IpToCountry.csv"
  end
  
  # Returns a country shortcode for a given IP.
  # Local vars:
  #   num_ip - numerical representation of the ip
  #   bottom, top, pivot - positions in the db file. Bottom and top indicate
  #     the current range I search within. Pivot is for binary search.
  #   hit - when 0 we found the entry; when 1 the entry is between pivot and top;
  #     when -1 the entry is between bottom and pivot
  #   line - the current line of db (where the pivot is)
  #   country - the shortcode I look for
  #
  # When the ip is not available in the db the behaviour of the method is undefined.
  def find_country_by_ip(ip)
    num_ip = ip2num ip
    bottom, top, pivot, hit = [0, @db.stat.size - 1, 0, 1]
    while hit != 0
      hit < 0 ? top = pivot : bottom = pivot
      pivot = (bottom + top) / 2
      line = readline(pivot)
      hit, country = check(num_ip, line)
    end
    country
  end
    
  private 
  
    # Converts ip to its numerical representation (4 digit number with 256 base).
    def ip2num(ip)
      result = 0
      ip.split(".").reverse.each_with_index { |num, i| result += num.to_i * (BASE ** i) }
      result
    end
    
    # Reads the line where the pos is.
    def readline(pos)
      @db.seek pos
      @db.seek(-2, IO::SEEK_CUR) if @db.tell > 0 and @db.getc == LINE_SEPARATOR
      @db.seek(-2, IO::SEEK_CUR) while @db.tell > 0 and @db.getc != LINE_SEPARATOR
      @db.readline
      # ML Exchange the above line with the following 3 lines to handle comments.
      # result = @db.readline
      # result = @db.readline while result =~ /^[#\s]/
      # result
    end
    
    # Checks the entry if the num_ip is withing its range.
    # Returns [0, shortcode] if it is.
    # Returns -1 if num_ip is below the range of the entry.
    # Returns 1 if num_ip is above the range of the entry.
    def check(num_ip, line)
      data = line.split(",")
      if num_ip < data[0].gsub("\"", "").to_i
        [-1, nil]
      elsif num_ip > data[1].gsub("\"", "").to_i
        [1, nil]
      else
        [0, data[4].gsub("\"", "")]
      end
    end
  
end