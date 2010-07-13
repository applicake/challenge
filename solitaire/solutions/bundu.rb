require File.dirname(__FILE__) + '/bundu/deck'
require File.dirname(__FILE__) + '/bundu/crypter'

class Bundu
  
  def initialize
    @crypter = Crypter.new(Deck.create)
  end
  
  def decrypt(message)
    @crypter.decrypt(message)
  end

  def encrypt(message)
    @crypter.encrypt(message)
  end
  
end