class Mateusz
  def load_database
    return true if self.class.loaded
    database = IO.readlines("IpToCountry.csv")
    self.class.database = database
    self.class.loaded = true
    self.class.database_size = database.size
    self.class.database_last = database.last.delete("\"").split(",")[1].to_f
  end

  def find_country_by_ip(ip)
    load_database
    search(ip_to_number(ip))
  end

  def ip_to_number(ip)
    ip_arr = ip.split(".")
    ip_arr[3].to_i + ( ip_arr[2].to_i * 256 ) + ( ip_arr[1].to_i * 256 * 256 ) + ( ip_arr[0].to_i * 256 * 256 * 256 )
  end

  def search(ip_number) 
    x = ip_number/self.class.database_last
    i = ( x*x* self.class.database_size).to_i

    loop do
      record = self.class.database[i].delete("\"").split(",")
      if record[0].to_i > ip_number
        i -= 1
      elsif record[1].to_i < ip_number
        i += 1
      else
        return record[4]
      end
    end
  end

  def self.loaded=(val)
    @loaded=val
  end

  def self.loaded
    @loaded
  end

  def self.database=(val)
    @database=val
  end

  def self.database
    @database
  end

  def self.database_size
    @database_size
  end

  def self.database_size=(val)
    @database_size=val
  end

  def self.database_last
    @database_last
  end

  def self.database_last=(val)
    @database_last=val
  end

  def self.reload
    @loaded = false
  end

end
