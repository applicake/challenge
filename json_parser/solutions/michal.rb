class Michal
  KEYWORDS = /true|false|null/
  NUMBERS = /-?\d+(?:(?:\.\d+)?(?:[eE][+-]?\d+)?)?/
  ESCAPE_SEQUENCES = /\\(?:\\|\"|b|f|n|r|t|u[0-9a-fA-F]{4})/
  STRINGS = /\"(?:[^\"\\]|#{ESCAPE_SEQUENCES})*\"/

  CHARACTERS = "{}[]:,"
  def parse(data)
    raise RuntimeError unless valid?(data)
    rubyized_json = data.gsub(/:/, "=>").gsub("null", "nil").gsub(STRINGS) do |match|
      match.gsub(/\\u([0-9a-fA-F]{4})/u) do
        ["#{$1}".hex ].pack('U')
      end
    end
    eval(rubyized_json)
  rescue SyntaxError
    raise RuntimeError
  end

  def valid?(data)
    data = data.clone
    data.gsub!(STRINGS, '')
    data.gsub!(KEYWORDS, '')
    data.gsub!(NUMBERS, '')
    data.delete!(CHARACTERS)
    data.strip!
    data == ""
  end
end
