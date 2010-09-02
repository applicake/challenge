class Jozef
  def fetch_less_then(max)
    @results = []
    max.times do |number|
      @a = [0]
      @number = number
      divs = []
      number.times do |e|
        e+=1
        if number.modulo(e) == 0 and number != e
          divs.push(e)
        end
      end

      if !abundant?(divs)
        next 
      else
        @abu = true
      end

      check(divs)
    end
    @results
  end

  def check(divs)
    divs.each do |d|
      aa = []
      @a.each do |e|
        return if (e + d) == @number
        (aa << e + d)
      end

      @a += aa
    end
    (@results << @number) if @abu
  end
  
  def abundant?(divs)
    counter = 0
    divs.each {|e| counter+=e}
    (counter > @number) ? true : false
  end
end

#18, 20, 24, 40...
