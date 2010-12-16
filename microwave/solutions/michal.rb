class Michal
  VALID_KEYS = (0..9).to_a + ['*']
  KEYS_COUNT = VALID_KEYS.length
  attr_reader :layout

  def initialize(layout)
    @layout = layout

    row_indices, col_indices = initialize_indices(layout)
    return if row_indices.include? nil # since we need to ignore incorrect layouts
    calculate_distances(row_indices, col_indices)
  end

  def initialize_indices(layout)
    row_indices, col_indices = Array.new(KEYS_COUNT), Array.new(KEYS_COUNT)

    layout.each_with_index do |row, row_index|
      row.each_with_index do |number, col_index|
        next unless number and VALID_KEYS.include? number
        number = KEYS_COUNT - 1 if number == '*'
        row_indices[number] = row_index                
        col_indices[number] = col_index
      end
    end
    [row_indices, col_indices]
  end

  def calculate_distances(row_indices, col_indices)
    @distances = Array.new(KEYS_COUNT) { Array.new(KEYS_COUNT) } # * == 10
    (0...KEYS_COUNT).each do |a|
      (0...KEYS_COUNT).each do |b|
        @distances[a][b] = Math.sqrt(
          (row_indices[a] - row_indices[b])**2 + (col_indices[a] - col_indices[b])**2
        )
      end
    end
  end
  

  def length(number)
    result = 0
    a = KEYS_COUNT - 1 # sequence ends with '*'
    while number > 0
      b = number % 10
      result += @distances[a][b]
      a = b
      number /= 10
    end
    result
  end

  def quickest_sequence(seconds)
    min_with_sec = (seconds / 60)*100 + seconds % 60
    better = length(seconds) < length(min_with_sec) ? seconds : min_with_sec
    "#{better}*"
  end
end
