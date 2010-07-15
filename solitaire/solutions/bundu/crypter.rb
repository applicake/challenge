class Bundu::Crypter
  
  CHARSET= ('A'..'Z').to_a

  attr_accessor :deck

  def initialize(deck)
    self.deck = deck
  end
  
  def encrypt(message)    
    converted = message.upcase.gsub(/[^A-Z]/, '')
    if (padding = 5 - converted.length % 5) != 5
      converted += 'X' * padding
    end
    
    result = []
    converted.length.times do |index|
      code = converted.slice(index) - 65
      encrypted = (code + deck.generate_keystream_number) % 26
      result << CHARSET[encrypted]
    end
    encrypted = result.join('')
    encrypted.scan(/.{1,5}/).join(' ')
  end
  
  def decrypt(encrypted)
    encrypted.gsub!(/[^A-Z]/, '')
    result = []
    self.deck.reload
    encrypted.length.times do |index|
      code = encrypted.slice(index) - 65
      decrypted = code - deck.generate_keystream_number
      decrypted = 26 + decrypted if decrypted < 0
      result << CHARSET[decrypted]
    end
    result.join('').scan(/.{1,5}/).join(' ')
  end
  
end


