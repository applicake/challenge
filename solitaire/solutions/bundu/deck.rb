class Deck < Array
    
  def self.create
    Deck.new((1..52).to_a + ['A', 'B'])
  end
  
  attr_accessor :backup
  
  def initialize(arr)
    super
    snapshot
  end
  
  def snapshot
    self.backup = self.to_a.dup
  end
  
  def reload
    self.replace(self.backup)
  end
  
  def move_card(element, places)
    dest = index(element) + places
    dest = dest % self.length if dest >= self.length
    dest = 1 if dest == 0
    self.insert(dest, delete(element))
  end
  
  def triple_cut(card_a, card_b)
    a, b = index(card_a), index(card_b)
    b, a = a, b if a > b
    top, bottom, middle = self[0..a-1], self[b+1..-1], self[a..b]
    self.replace bottom + middle + top
  end

  def count_cut
    return if ['A', 'B'].include?(last)
    cut, rest = self.slice(0, last), self[last..-1]
    last_card = rest.pop
    self.replace rest + cut + [last_card]
  end
    
  def generate_keystream_number
    # 1. Key the deck
    # At this point we're assuming the deck is keyed
    # 2. Move the A joker down one card
    move_card('A', 1)
    # 3. Move the B joker down two cards.
    move_card('B', 2)
    # 4. Perform a triple cut around the two jokers
    triple_cut('A', 'B')
    # 5. Perform a count cut using the value of the bottom card
    count_cut
    # 6. Fetch the keystream letter
    offset = self.first.is_a?(Fixnum) ? self.first : 53
    letter = self[offset]
    letter.is_a?(Fixnum) ? (letter % 26) : generate_keystream_number
  end

  def generate_keystream(length)
    result = []
    length.times do
      number = generate_keystream_number 
      result << number if number
    end
    result
  end

end