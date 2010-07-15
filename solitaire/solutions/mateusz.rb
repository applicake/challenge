
class Array

  def split(index)
     self.flatten!
     return [self[0,index], self[index,self.length]]
  end
  
  def move(element, movement)
    element_position = self.index(element)
    self.delete_at(element_position)
    position = element_position + movement
    
    while position < 0
      position = self.length + position
    end
    while position > self.length
      position = position - self.length
    end

    a,b = self.split(position)
    
    self.replace([a,element,b].flatten)
  end
end

class Integer
  def to_real
    self < 0 ? 0 : self
  end
end


class Mateusz
  class Joker
    def self.to_i
      53
    end
  end
  class A < Joker;end
  class B < Joker;end
  
  def self.convert_to_letter(index)
    return nil if index >= 53
    if index > 26
      index = index - 26
    end
    ("A".."Z").to_a[index-1]
  end
  
  def self.convert_to_number(letter)
    ("A".."Z").to_a.index(letter)+1
  end
  
    
    def init(data)
      data = data.upcase.gsub(/[^A-Z]/,"")
      to_add = (data.length % 5)
      to_add = 5- to_add if to_add != 0
      data << "X"*to_add
      
      data_numbers = []
      keystream_numbers = []
      deck = Deck.new
      data.length.times do |i|
       data_numbers << Mateusz.convert_to_number(data[i..i])
       begin
         letter = deck.generate_keystream_letter 
         raise "dupa" if letter.nil?
       rescue
         retry
       end
       keystream_numbers << Mateusz.convert_to_number(letter)
      end
      return data_numbers, keystream_numbers
      
    end
    
    def encrypt(data)
      data_numbers, keystream_numbers = init(data)
      output_letters = []
      keystream_numbers.length.times do |i|
        output = keystream_numbers[i] + data_numbers[i]
        output_letters << (output > 26 ? output - 26 : output)
      end
      output_letters = output_letters.map {|o| Mateusz.convert_to_letter(o)}
      temp_bucket =[]
      output = []
      output_letters.length.times do
        temp_bucket << output_letters.shift
        if temp_bucket.size == 5
          output << temp_bucket.to_s
          temp_bucket.clear
        end
        
      end
      output.join(" ")
    end
        
    def decrypt(data)
      data_numbers, keystream_numbers = init(data)

      output_letters = []
      keystream_numbers.length.times do |i|
        output = data_numbers[i] - keystream_numbers[i]
        output_letters << (output < 0 ? output + 26 : output)
      end
      output_letters = output_letters.map {|o| Mateusz.convert_to_letter(o)}
      temp_bucket =[]
      output = []
      output_letters.length.times do
        temp_bucket << output_letters.shift
        if temp_bucket.size == 5
          output << temp_bucket.to_s
          temp_bucket.clear
        end
        
      end
      output.join(" ")
    end

  
  
  class Deck
    attr_accessor :deck
    
    def initialize
      @deck = (1..52).to_a.concat([A,B])
    end
    
    def generate_keystream_letter
    
      @deck.move(A,1).move(B,2)
      first, last  = [@deck.index(A),@deck.index(B)].sort
      triple_cut = [@deck[(last+1)..-1],@deck[first..last]]
      triple_cut << @deck[0..(first-1)] if first > 0
      
      @deck.replace triple_cut.flatten
      @deck.replace [@deck[@deck[-1].to_i..-2], @deck[0..(@deck[-1].to_i-1)], @deck[-1]].flatten
      Mateusz.convert_to_letter(@deck[@deck.first.to_i].to_i)
    end

  end
end

