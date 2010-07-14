LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')

LETTERS_HASH = {}
LETTERS.each_with_index do |letter, index|
  LETTERS_HASH[letter] = index + 1 if index < 26  
end

class String
   def convert_to_i
     LETTERS_HASH[self] 
#     LETTERS.index(self) + 1 
   end 
   def extend_with_blanks 
     total_letters_no = ((length/5 + 1 )*5 - length).modulo(5) + length 
     ljust( total_letters_no, 'X')
   end 
end 
 
class Integer 
  def convert_to_s
    LETTERS[self-1]
  end
end

class Keystream 
  attr_reader :keystream 
  def initialize(length) # 0 - A joker , -1 - B joker
    @keystream = []
    @counter = 0
    @deck = Array.new(52) {|i| i+1} << 0 << -1  
    while @counter < length  do 
      create
    end 
  end 

  def create
     #2
     new_jokerA_index = @deck.index(0) + 1
     new_jokerA_index = 1 if new_jokerA_index == 54
     @deck.insert(new_jokerA_index, @deck.delete(0))
     #3 
     new_jokerB_index = @deck.index(-1) + 2
     if new_jokerB_index > 53 
       new_jokerB_index = new_jokerB_index.modulo(53)
     end
     @deck.insert(new_jokerB_index , @deck.delete(-1))
    #4 
    if (joker1 = @deck.index(0)) < (joker2 = @deck.index(-1))
       top_joker_index = joker1
       bottom_joker_index = joker2
     else 
       top_joker_index = joker2
       bottom_joker_index = joker1
     end 
     
     top_part, middle_part, bottom_part = [], [], []

     top_part = @deck[ 0..(top_joker_index - 1 ) ] if top_joker_index != 0
     bottom_part = @deck[ (bottom_joker_index + 1)..53 ] if bottom_joker_index != 53
     middle_part = @deck[ top_joker_index..bottom_joker_index]
    
     @deck = bottom_part + middle_part + top_part

     #5 
     first_part = @deck[ 0..(@deck[53]-1)] 
     second_part = @deck[ (@deck[53])..52] 
     @deck =  second_part + first_part + [@deck[53]]
    #6 
     number  = @deck[0] 
     number = -1 if number  == 0  
     if (letter_int = @deck[number]) > 0 
       @keystream << LETTERS_HASH[ LETTERS[letter_int -1]]  #.convert_to_i #.convert_to_s #unless letter_int < 1  
       @counter = @counter + 1 
     end 
  end 
end

class SolitaireCipher
  attr_reader :message, :coded_message 
  def initialize(args)
    unless args.has_key?(:coded_message) or args.has_key?(:message)
      raise "Please specify either message or coded_message hash"
    end 
    @message = args[:message].gsub(/[^A-Za-z]/, '').upcase.extend_with_blanks if args[:message]
    @coded_message  =  args[:coded_message].gsub(/ /,'') if args[:coded_message]
    if @message 
      @lenght = @message.length 
    else
      @lenght = @coded_message.length 
    end 
    @keystream = Keystream.new(@lenght).keystream
  end 
  
  def code
    raise 'There is no message to be coded!' unless @message 
    coded_message = ''
    index = 0 
    @message.each_char do |letter|
      coded_message << LETTERS[(( sum = LETTERS_HASH[letter] + @keystream[index]) > 26 ? sum - 26: sum) - 1] #.convert_to_s
      index = index + 1 
    end 
    @coded_message = coded_message.scan(/.{1,5}/).join(' ')
  end 

  def decode
    raise 'There is no message to be decoded!' unless @coded_message 
    decoded_message = ''
    index = 0 
    @coded_message.each_char do |letter|
      decoded_message << LETTERS[(( diff = LETTERS_HASH[letter] - @keystream[index]) > 0 ? diff : diff + 26) -1 ] #.convert_to_s
      index = index + 1 
    end 
    @message = decoded_message.scan(/.{1,5}/).join(' ')
  end
end 

class Kiszal
  def decrypt(coded_message)
    SolitaireCipher.new(:coded_message => coded_message).decode
  end
  def encrypt(message)
    SolitaireCipher.new(:message => message).code
  end 
end 


#     #4  
#     if (joker1 = @deck.index(0)) < (joker2 = @deck.index(-1))
#       top_joker_index = joker1
#       top_joker = 0
#     else 
#
#       top_joker_index = joker2
#       top_joker = -1 
#     end 
#
#     up_cut, down_cut = [], [] 
#     up_cut = @deck.slice!( 0..(top_joker_index - 1 ) ) if top_joker_index != 0
#     bottom_joker = (-1 * ( -1 + top_joker)) -2 #returns number of the bottom joker
#     bottom_joker_index = @deck.index(bottom_joker)
#     down_cut = @deck.slice!( (bottom_joker_index+1)..(53-top_joker_index))  if bottom_joker_index != (53-top_joker_index)
#          
#     @deck.insert(0, down_cut)
#     @deck.insert(-1, up_cut)
#     @deck.flatten!.compact!


#     #5
#     @deck.insert( -2,  @deck.slice!(0..(@deck.last-1))).flatten!.compact!

 

#require 'rubygems'
#require 'ruby-prof'
#
#RubyProf.start
#5.times { Kiszal.new.encrypt( 'Aa@' * 500) }
#result = RubyProf.stop
#
## Print a flat profile to text
#printer = RubyProf::FlatPrinter.new(result)
#printer.print(STDOUT, 0)
#

