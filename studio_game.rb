def say_hello(name, health=100)
  "I'm #{name.capitalize} with a health of #{health} as of #{time}."
end

def time
  current_time = Time.new
  current_time.strftime('%H:%M:%S')
end

puts say_hello('larry', 60)
puts say_hello('curly', 125)
puts say_hello('moe')
puts say_hello('shemp', 90)

current_formatted_time = Time.new.strftime('%A %m/%d/%Y at %H:%M')
puts "The game started on #{current_formatted_time}"