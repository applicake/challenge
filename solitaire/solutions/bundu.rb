class Bundu
  
  def initialize
    @crypter = Bundu::Crypter.new(Bundu::Deck.create)
  end
  
  def decrypt(message)
    @crypter.decrypt(message)
  end

  def encrypt(message)
    @crypter.encrypt(message)
  end
  
end

require File.dirname(__FILE__) + '/bundu/crypter'
require File.dirname(__FILE__) + '/bundu/deck'