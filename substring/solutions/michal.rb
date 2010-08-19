class Michal
  def fetch_substring(string)
    results = []
    (string.length / 2).downto(2) do |length|
      0.upto(string.length - length * 2) do |start|
        candidate = string[start, length]
        rest = string[(start+length)..-1]
        results << candidate if rest.include? candidate
      end
      break unless results.empty?
    end 
    results.uniq.join(' ')
  end
end
