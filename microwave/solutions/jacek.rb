class Jacek
  attr_reader :layout

  def initialize(layout)
    @layout = layout
    @coordinates = {}
    @layout.each_with_index do |row,y|
      row.each_with_index do |key, x|
        @coordinates[key] = [x,y]
      end
    end
#puts @coordinates.inspect
  end

  def metric(sequence)
    coords = sequence.collect {|key| @coordinates[key]}
    last_coord = coords.shift
    coords.inject(0) {|total, coord| distance =  Math.sqrt((coord[0]-last_coord[0])**2 + (coord[1]-last_coord[1])**2); last_coord = coord; total + distance}
  end

  def quickest_sequence(seconds)
    return sequences(seconds).sort {|a,b| metric(a) <=> metric(b)}.first.join
  end

  def sequences(total_seconds)
    minutes = total_seconds / 60
    seconds = total_seconds % 60
    r = []
    if minutes == 0
      r << [seconds / 10, seconds % 10]
    else
      if (seconds + 60) < 100 # we can move minutes to seconds
        m2 = minutes - 1
        s2 = seconds + 60
        r << [m2 / 10, m2 % 10, s2 / 10, s2 % 10]
      end
      r << [minutes / 10, minutes % 10, seconds / 10, seconds % 10]
    end
    r.collect {|sequence| while sequence.first == 0; sequence.shift; end; sequence + ['*']}
  end
end
