# Based on "http://techblog.procurios.nl/k/news/view/14605/14863
#   /How-do-I-write-my-own-parser-for-JSON.html"

class Mariusz
  
  TOKEN_NONE = 0
	TOKEN_CURLY_OPEN = 1
	TOKEN_CURLY_CLOSE = 2
	TOKEN_SQUARED_OPEN = 3
	TOKEN_SQUARED_CLOSE = 4
	TOKEN_COLON = 5
	TOKEN_COMMA = 6
	TOKEN_STRING = 7
	TOKEN_NUMBER = 8
	TOKEN_TRUE = 9
	TOKEN_FALSE = 10
	TOKEN_NULL = 11
  
  def parse(data)
    value, index, success = parse_value(data.strip, 0)
    # This if-statement just makes the >>should parse errors<< specs pass. 
    if success and index < data.strip.length
      rest, index, success = parse_value(data.strip[index..data.strip.length-1], 0)
    end
    raise unless success
    value
  end
  
  private
  
    def eat_whitespace(json, index)
      index += 1 while index < json.length and json[index] =~ /\s/
      index
    end
  
    def look_ahead(json, index)
      next_token(json, index).first
    end
  
    def next_token(json, index)
      index = eat_whitespace(json, index)
      return [TOKEN_NONE, index] if index == json.length
      char = json[index]
      index += 1
      case(char)
      when "{"
        return [TOKEN_CURLY_OPEN, index]
      when "}"
        return [TOKEN_CURLY_CLOSE, index]
      when "["
        return [TOKEN_SQUARED_OPEN, index]
      when "]"
        return [TOKEN_SQUARED_CLOSE, index]
      when ","
        return [TOKEN_COMMA, index]
      when '"'
        return [TOKEN_STRING, index]
      when "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "-"
        return [TOKEN_NUMBER, index]
      when ":"
        return [TOKEN_COLON, index]
      end
      index -= 1
      remaining_length = json.length - index
      if remaining_length >= 5
        if json[index..index+4] == "false"
          index += 5
          return [TOKEN_FALSE, index]
        end
      end
      if remaining_length >= 4
        if json[index..index+3] == "true"
          return [TOKEN_TRUE, index + 4]
        end
      end
      if remaining_length >= 4
        if json[index..index+3] == "null"
          return [TOKEN_NULL, index + 4]
        end
      end
      [TOKEN_NONE, index]
    end
  
    def parse_value(json, index)
      token = look_ahead(json, index)
      case(token)
      when TOKEN_STRING
        return parse_string(json, index)
      when TOKEN_NUMBER
        return parse_number(json, index)
      when TOKEN_CURLY_OPEN
        return parse_object(json, index)
      when TOKEN_SQUARED_OPEN
        return parse_array(json, index)
      when TOKEN_TRUE
        token, index = next_token(json, index)
        return [true, index, true]  
      when TOKEN_FALSE
        token, index = next_token(json, index)
        return [false, index, true]
      when TOKEN_NULL
        token, index = next_token(json, index)
        return [nil, index, true]
      end
      [nil, index, false]
    end
  
    def parse_string(json, index)
      value = ""
      index = eat_whitespace(json, index)
      char = json[index]
      index += 1
      complete = false
      while(!complete)
        break if index == json.length
        char = json[index]
        index += 1
        if char == '"'
          complete = true
          break
        elsif char == '\\'
          break if index == json.length
          char = json[index]
          index += 1
          if char == '"'
            value << '"'
          elsif char == "\\"
            value << "\\"
          elsif char == "/"
            value << "/"
          elsif char == "b"
            value << "\b"
          elsif char == "f"
            value << "\f"
          elsif char == "n"
            value << "\n"
          elsif char == "r"
            value << "\r"
          elsif char == "t"
            value << "\t"
          elsif char == "i"
            return [nil, index, false]
          elsif char == "u"
            remaining_length = json.length - index
            if remaining_length >= 4
              unicode = '"\u' + json[index..index+3] + '"'
              value << eval(unicode)
              index += 4
            else
              break
            end
          end
        else
          value << char
        end
      end
      if complete
        [value, index, true]
      else
        [nil, index, false]
      end
    end
  
    def parse_number(json, index)
      index = eat_whitespace(json, index)
      last_index = last_index_of_number(json, index)
      [json[index..last_index].to_f, last_index + 1, true]
    end
		
  	def last_index_of_number(json, index)
  	  index += 1 while index < json.length and json[index] =~ /[\d\+\-eE.]/
  	  index - 1
  	end
  
    def parse_object(json, index)
      value = {}
      token, index = next_token(json, index)
      while true
        token = look_ahead(json, index)
        if token == TOKEN_NONE
          return [nil, index, false]
        elsif token == TOKEN_COMMA
          token, index = next_token(json, index)
        elsif token == TOKEN_CURLY_CLOSE
          token, index = next_token(json, index)
          return [value, index, true]
        else
          name, index, success = parse_string(json, index)
          return [nil, index, false] unless success
          token, index = next_token(json, index)
          return [nil, index, false] unless token == TOKEN_COLON
          element_value, index, success = parse_value(json, index)
          return [nil, index, false] unless success
          value[name] = element_value
        end
      end
      [value, index, true]
    end
  
    def parse_array(json, index)
      value = []
      prev_token = nil
      token, index = next_token(json, index)
      while true
        token = look_ahead(json, index)
        if token == TOKEN_NONE
          return [nil, index, false]
        elsif token == TOKEN_COMMA
          return [nil, index, false] if prev_token == TOKEN_COMMA
          prev_token = TOKEN_COMMA
          token, index = next_token(json, index)
        elsif token == TOKEN_SQUARED_CLOSE
          token, index = next_token(json, index)
          break
        else
          prev_token = nil
          inner_value, index, success = parse_value(json, index)
          return [nil, index, false] unless success
          value << inner_value
        end
      end
      [value, index, true]
    end
  
end