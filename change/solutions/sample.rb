class Sample
  #def change(money, coins)
    #rest = money
    #nominals = coins.sort
    #result = []
    #until nominals.empty?
      #current = nominals.pop
      #while rest >= current
        #rest -= current 
        #result << current
      #end
    #end
    #rest == 0 ? result : []
  #end

  #def change(money, coins)
    #rest = money
    #nominals = coins.sort
    #result = []
    #until nominals.empty?
      #current = nominals.pop
      #while rest >= current
        #times = rest / current
        #rest -= current * times
        #result.concat([current] * times)
      #end
    #end
    #rest == 0 ? result : []
  #end

  #def change(money, coins)
    #nominals = coins.sort.reverse
    #result = []
    #nominals.each do |current|
      #if money >= current
        #times = money / current
        #money -= current * times
        #result.concat(Array.new(times, current))
      #end
    #end
    #money == 0 ? result : []
  #end
  def change(money, coins)
    nominals = coins.sort
    result = []
    until nominals.empty?
      current = nominals.pop
      if money >= current
        times = money / current
        money -= current * times
        result.concat(Array.new(times, current))
      end
    end
    money == 0 ? result : []
  end
end
