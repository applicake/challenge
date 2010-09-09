class Agatka
  
  def initialize
  end
  
  def find_country_by_ip(ip)
    numbers = ip.split(".")
    final_ip = numbers[0].to_i*256*256*256 + numbers[1].to_i*256*256 + numbers[2].to_i*256 + numbers[3].to_i

    lines = File.readlines("IpToCountry.csv")
    (lines.length/2).times do
      ips = lines[lines.length/2-1].split(',').values_at(0, 1, 4).collect{|x| x.delete("\"")}
      if final_ip >= ips[0].to_i
        if final_ip <= ips[1].to_i
          return ips[2]
        else
          lines = lines[(lines.length/2)..(lines.length-1)]
        end
      else
        lines = lines[0..(lines.length/2)]
      end
    end
  end

end