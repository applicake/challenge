LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')
LETTERS_HACK = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZa'.split('')


LETTERS_HASH = {}
LETTERS.each_with_index do |letter, index|
  LETTERS_HASH[letter] = index + 1 if index < 26  
end
LETTERS_HASH["a"] = ''

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
  def initialize(length) # 53 - A joker , -1 - B joker
    @keystream = ''
    @counter = 0
    @indexA = 52
    @indexB = 53
    @deck = Array.new(53) {|i| i+1} << -1   
    while @counter < length  do 
      self.create
    end 
  end 

  def create
     #2
     
     new_jokerA_index = @indexA + 1
     new_jokerA_index = 1 if new_jokerA_index == 54
     @deck.insert(new_jokerA_index, @deck.delete_at(@indexA) )
     

     #indexB cache update   
     if  new_jokerA_index >= @indexB and @indexB > @indexA
       @indexB = @indexB - 1
     elsif @indexB > new_jokerA_index and @indexB < @indexA
       @indexB = @indexB + 1 
     end

     @indexA = new_jokerA_index 


     #3 
     new_jokerB_index = @indexB + 2
     if new_jokerB_index > 53 
       new_jokerB_index = new_jokerB_index.modulo(53)
     end
     @deck.insert(new_jokerB_index , @deck.delete_at(@indexB))
     
     #indexA cache update   
     if new_jokerB_index >= @indexA and @indexB < @indexA
       @indexA = @indexA - 1 
     elsif new_jokerB_index < @indexA and @indexB > @indexA
       @indexA = @indexA + 1 
     end 

     @indexB = new_jokerB_index 
    #4 

    if  @indexA < @indexB
       top_joker_index = @indexA
       bottom_joker_index = @indexB
     else 
       top_joker_index = @indexB
       bottom_joker_index = @indexA
     end 
     
     top_part, middle_part, bottom_part = [], [], []

     top_part = @deck[ 0..(top_joker_index - 1 ) ] #if top_joker_index != 0
     bottom_part = @deck[ (bottom_joker_index + 1)..53 ] #if bottom_joker_index != 53
     middle_part = @deck[ top_joker_index..bottom_joker_index]
     
     @deck =  bottom_part + middle_part + top_part

     #5 
     first_part = @deck[ 0..(@deck[53]-1)] 
     second_part = @deck[ (@deck[53])..52] 
     @deck =  second_part + first_part + [@deck[53]]
    #6 
     if (letter_int = @deck[@deck[0]]) > 0 
       @keystream << LETTERS_HASH[ LETTERS_HACK[letter_int -1]]  #.convert_to_i #.convert_to_s #unless letter_int < 1  
       @counter = @counter + 1 unless letter_int == 53 
     end 
     #joker index cache update
     @indexA = @deck.index(53) 
     @indexB = @deck.index(-1) 
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
      coded_message << LETTERS[ LETTERS_HASH[letter] + @keystream[index] - 1] #.convert_to_s
      index = index + 1 
    end 
    @coded_message = coded_message.gsub!(/.{1,5}/) {|m| m = m + ' '}.gsub!(/ $/, '')
  end 

  def decode
    raise 'There is no message to be decoded!' unless @coded_message 
    decoded_message = ''
    index = 0 
    @coded_message.each_char do |letter|
      decoded_message << LETTERS[ LETTERS_HASH[letter] - @keystream[index] -1 ] #.convert_to_s
      index = index + 1 
    end 
    @message = decoded_message.gsub!(/.{1,5}/) {|m| m = m + ' '}.gsub!(/ $/, '')
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


