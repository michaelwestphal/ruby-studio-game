def conversation
  puts "Hello"
  yield
  puts "Goodbye"
end

conversation { puts "Nice to meet you!" }

def five_times
  # It didn't even occur to me to do it this way...
  # I went immediately to the upto usage below
  # yield 1
  # yield 2
  # yield 3
  # yield 4
  # yield 5
  1.upto(5).each do |n|
    yield n
  end
end

five_times do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end

def n_times(number)
  1.upto(number).each do |count|
    yield count
  end
end

n_times(5) do |n|
  puts "#{n} situps"
  puts "#{n} pushups"
  puts "#{n} chinups"
end
