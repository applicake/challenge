require File.join File.dirname(__FILE__), "list"

class Deck
  
  def reset
    @list = List.create_list
    52.times { |i| @list.insert List.create_list_element(Card.new(i, (65 + i % 26).chr))}
    @jokerA = List.create_list_element(Card.new(52, nil))
    @jokerB = List.create_list_element(Card.new(52, nil))
    @list.insert @jokerA
    @list.insert @jokerB
    @jokerA_index = 52
    @jokerB_index = 53
  end
  
  def next_key
    move_jokerA_one_down
    move_jokerB_two_down
    triple_cut
    count_cut
    # ML If nil is the output letter skip it and run the procedure once again.
    find_output_letter || next_key
  end
  
  def print
     @list.print
  end
  
  private
  
    def move_jokerA_one_down
      @list.move_down @jokerA
      handle_joker_indices :jokerA_one_down
    end
    
    def move_jokerB_two_down
      @list.move_down @jokerB, 2
      handle_joker_indices :jokerB_two_down
    end
    
    def triple_cut
      if @jokerA_index < @jokerB_index
        top_joker = @jokerA
        bottom_joker = @jokerB
      else
        top_joker = @jokerB
        bottom_joker = @jokerA
      end
      top_cut = nil
      bottom_cut = nil
      if top_joker != @list.head
        top_cut = @list.remove_range @list.head, top_joker.prev
      end
      if bottom_joker != @list.tail
        bottom_cut = @list.remove_range bottom_joker.next, @list.tail
      end
      @list.insert_list bottom_cut, @list.head
      @list.insert_list top_cut
      handle_joker_indices :triple_cut
    end
    
    def count_cut
      index = @list.tail.obj.value
      element = @list.retrieve_at index
      tmp_list = @list.remove_range @list.head, element
      @list.insert_list tmp_list, @list.tail
      handle_joker_indices :count_cut, :cut_index => index
    end
    
    def find_output_letter
      @list.retrieve_at(@list.head.obj.value).next.obj.letter
    end
    
    def handle_joker_indices(operation, options = {})
      case operation
      when :jokerA_one_down
        if @jokerB_index == @jokerA_index + 1
          @jokerB_index -= 1
        end
        @jokerA_index += 1
        if @jokerA_index == 54
          @jokerA_index = 1
          @jokerB_index += 1 if @jokerB_index > 0
        end
      when :jokerB_two_down
        if @jokerA_index == @jokerB_index + 1 or @jokerA_index == @jokerB_index + 2
          @jokerA_index -= 1
        end
        if @jokerB_index == 52 or (@jokerB_index == 53 and @jokerA_index > 1)
          @jokerA_index += 1
        end
        @jokerB_index += 2
        @jokerB_index -= 53 if @jokerB_index > 53
      when :triple_cut
        if @jokerA_index < @jokerB_index
          diff = @jokerB_index - @jokerA_index
          @jokerA_index = 53 - @jokerB_index
          @jokerB_index = @jokerA_index + diff
        else
          diff = @jokerA_index - @jokerB_index
          @jokerB_index = 53 - @jokerA_index
          @jokerA_index = @jokerB_index + diff
        end
      when :count_cut
        if @jokerA_index < 53
          if @jokerA_index <= options[:cut_index]
            @jokerA_index = 52 - options[:cut_index] + @jokerA_index
          else
            @jokerA_index = @jokerA_index - options[:cut_index] - 1
          end
        end
        if @jokerB_index < 53
          if @jokerB_index <= options[:cut_index]
            @jokerB_index = 52 - options[:cut_index] + @jokerB_index
          else
            @jokerB_index = @jokerB_index - options[:cut_index] - 1
          end
        end
      end
    end
    
end

class Card
  
  attr_accessor :value, :letter
  
  def initialize(value, letter)
    @value = value
    @letter = letter
  end
  
  def print
    puts "Card. Value = #{@value}, letter = #{@letter.inspect}."
  end
  
end