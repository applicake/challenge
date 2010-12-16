class Basia
  attr_reader :layout

  def initialize(layout)
    @layout = layout || [[1,2,3],[4,5,6],[7,8,9],[0,'*',nil]]
  end

  def quickest_sequence(seconds)
    if seconds < 60
       "#{seconds}*"
    else
      minutes, only_seconds = seconds.divmod(60)
      (only_seconds.to_s.length < 2) ? only_seconds = "#{only_seconds}0" : ''
      array = prepare_array(minutes) + prepare_array(only_seconds)
      with_minutes = calculate_distance(array)
      with_seconds = calculate_distance(prepare_array(seconds))
      with_minutes > with_seconds ? "#{seconds}*" : "#{minutes}#{only_seconds}*"
    end
  end

  def calculate_distance(array)
     sum = get_distance(array.last, '*')
     (array.length-1).times do |i|
       sum += get_distance(array[i], array[i+1])
     end 
     return sum
  end

  def prepare_array(number)
    number.to_s.split(//).collect{|x| x.to_i}
  end

  def get_distance(point1, point2)
    row1 = layout.index{|x| @col1=x.index(point1)}
    row2 = layout.index{|x| @col2=x.index(point2)}
    pon = (row2 - row1).abs + (@col2 - @col1).abs + 2
  end
end
