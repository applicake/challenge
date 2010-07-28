require File.dirname(__FILE__) + '/../shared/benchmark' unless defined?(Challenge)

ITERATIONS = 10
STORES = 1000
FETCHES = 1000
DELETES = 1000
HAS_KEYS = 1000
LENGTHS = 1000
STRINGS = 1000

def key(index)
  key = 'a' * STRINGS
  key[index] = 'z'
  key
end

srand(666)
indices = (0...STRINGS).to_a.sort_by { rand }

Challenge::Benchmark.new do
  iterations ITERATIONS
  title " store"
  before { @hashish = solution.constant.new }
  
  action do
    STORES.times do |i|
      @hashish.store(key(i), "value")
    end    
  end
end

Challenge::Benchmark.new do
  iterations ITERATIONS
  title " fetch"
  before do
    @hashish = solution.constant.new 
    FETCHES.times do |i|
      @hashish.store(key(i), "value")
    end    
  end
  
  action do
    FETCHES.times do |i|
      @hashish.fetch(key(i))
    end    
  end
end
Challenge::Benchmark.new do
  iterations 1
  title " delete"
  before do
    @hashish = solution.constant.new 
    DELETES.times do |i|
      @hashish.store(key(i), "value")
    end    
  end
  
  action do
    DELETES.times do |i|
      @hashish.delete(key(i))
    end    
  end
end



Challenge::Benchmark.new do
  iterations ITERATIONS
  title " has_key?"
  before do 
    @hashish = solution.constant.new 
    HAS_KEYS.times do |i|
      @hashish.store(key(i), "value")
    end
  end
  
  action do
    HAS_KEYS.times do |i|
      good_key = key(i)
      @hashish.has_key?(good_key)
      bad_key = good_key + 'x'
      @hashish.has_key?(good_key)
    end    
  end
end

Challenge::Benchmark.new do
  iterations ITERATIONS
  title " length"
  before do 
    @hashishes = []
    LENGTHS.times do |i|
      @hashishes <<  solution.constant.new
      (0..i).each do |j| 
        @hashishes[i].store(key(j), "value")
      end
    end
  end
  
  action do
    LENGTHS.times do |i|
      @hashishes[i].length
    end    
  end
end
