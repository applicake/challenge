class Bundu::Deck < Array
    
  def self.create
    Bundu::Deck.new((1..54).to_a)
  end
  
  attr_accessor :backup
  
  def initialize(arr)
    super
    snapshot
  end
  
  # The length of the deck array is constant, 
  # so it makes no sense to calculate the length over and over again
  # save it in an instance variable and enjoy the speed
  def cached_length
    @cached_length ||= self.length
  end
  
  def snapshot
    self.backup = self.to_a.dup
  end
  
  def reload
    self.replace(self.backup)
  end
  
  def move_card(element, places)
    dest = index(element) + places
    if dest >= self.cached_length
      dest = dest - self.cached_length
      dest = 1 if dest == 0
    end
    self.insert(dest, delete(element))
  end
  
  def triple_cut(card_a, card_b)
    a, b = index(card_a), index(card_b)
    b, a = a, b if a > b
    top, bottom, middle = self[0, a], self[b+1, self.cached_length-b+1], self[a, b-a+1]
    self.replace bottom + middle + top
  end

  def count_cut    
    cut = self.slice!(0, last)
    self.insert(self.cached_length - last - 1, *cut)
  end
    
  def generate_keystream_number
    # 1. Key the deck
    # At this point we're assuming the deck is keyed
    # 2. Move the A joker down one card
    move_card(53, 1)
    # 3. Move the B joker down two cards.
    move_card(54, 2)
    # 4. Perform a triple cut around the two jokers
    triple_cut(53, 54)
    # 5. Perform a count cut using the value of the bottom card
    count_cut unless last > 52
    # 6. Fetch the keystream letter
    offset = first < 53 ? first : 53
    self[offset] < 53 ? (self[offset] % 26) : generate_keystream_number
  end

end
