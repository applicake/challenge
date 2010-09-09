#!/usr/bin/ruby

class Mlody

  def initialize
    @file = File.open("IpToCountry.csv", "r")
    @size = File.size("IpToCountry.csv")
  end

  def find_country_by_ip(arg)
    ip = iptoform(arg)
    search(ip, 0, @size)
  end

  def search(ip, start, finish)
    here = (start+finish)/2
    
    @file.seek(here, File::SEEK_SET) and @file.readline
    l = @file.readline.split('"') and length = l.size
    from = l[1].to_i; to = l[3].to_i
    return l[9] if (from .. to).include?(ip)

    (ip < from) ? (return search(ip, start, here-2)) : (return search(ip, here+length, finish))
  end


  def iptoform(ip_s)
      ip = ip_s.split(".")
      ip_num = ip[0].to_i * 256 ** 3 +
      ip[1].to_i * 256 ** 2 +
      ip[2].to_i * 256 ** 1 +
      ip[3].to_i
      return ip_num
  end
end
