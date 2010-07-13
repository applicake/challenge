class Crypter
  
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
    
    keystream = deck.generate_keystream(converted.length)
    result = []
    converted.split('').each_with_index do |char, index|
      code = CHARSET.index(char) 
      encrypted = (code.to_i + keystream[index].to_i) % 26
      result << CHARSET[encrypted]
    end
    encrypted = result.join('')
    encrypted.scan(/.{1,5}/).join(' ')
    
  end
  
  def decrypt(encrypted)
    encrypted.gsub!(/[^A-Z]/, '')
    result = []
    self.deck.reload
    keystream = deck.generate_keystream(encrypted.length)
    encrypted.split('').each_with_index do |char, index|
      if char.match(/[A-Z]/i)
        code = CHARSET.index(char) 
        decrypted = code - keystream[index] 
        decrypted = 26 + decrypted if decrypted < 0
        result << CHARSET[decrypted]
      else
        result << char
      end
    end
    result.join('').scan(/.{1,5}/).join(' ')
  end
  
end