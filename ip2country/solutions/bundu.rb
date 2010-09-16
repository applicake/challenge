class Bundu
  
  def initialize
    @lines = {}
    @file =  File.open('IpToCountry.csv', 'r')
    
    # This is where we lose most of the time
    while line = @file.gets
      (@lines[line[1, 5]] ||= []) << line
    end
  end
  
  def find_country_by_ip(ip)
    converted = convert_ip(ip)
    
    prefix = converted.to_s[0,5]
    while !(subset = @lines[prefix])
      # If we missed, this means there's a minimum with a smaller prefix
      # We find it here
      prefix = (prefix.to_i - 1).to_s
    end
    subset.each do |candidate|
      split = candidate.split(',')
      if converted >= split[0][1..-2].to_i and converted <= split[1][1..-2].to_i
        return split[4][1..-2]
      end
    end
    nil
  end
  
  def convert_ip(ip)
    parts = ip.split('.')
    (parts[3].to_i) + (parts[2].to_i * 256) + (parts[1].to_i * 65536) + (parts[0].to_i * 16777216)
  end
  
end