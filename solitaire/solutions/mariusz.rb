require File.join File.dirname(__FILE__), "mariusz", "deck"

class Mariusz
  
  def initialize
    @deck = Deck.new
  end
  
  def encrypt(text)
    @deck.reset
    text = prepare_text text
    generate_code text, generate_key(text.length)
  end
  
  def decrypt(code)
    @deck.reset
    code = prepare_code code
    generate_text code, generate_key(code.length)
  end
  
  private
  
    def prepare_text(text)
      result = text.gsub(/[^A-Za-z]/, "").upcase
      (mod = result.length % 5) > 0 ? result << "X" * (5 - mod) : result
    end
    
    def prepare_code(code)
      code.gsub " ", ""
    end
    
    def generate_key(length)
      Array.new(length).map! { @deck.next_key }.join
    end
    
    def generate_code(text, key)
      text.length.times.map do |i|
        result = (((sum = text[i] + key[i] - 128) > 26) ? sum + 38 : sum + 64).chr
        result += " " if i % 5 == 4
        result
      end.join.strip
    end
    
    def generate_text(code, key)
      code.length.times.map do |i|
        result = (((sub = code[i] - key[i]) > 0) ? sub + 64 : sub + 90).chr
        result += " " if i % 5 == 4
        result
      end.join.strip
    end
  
end