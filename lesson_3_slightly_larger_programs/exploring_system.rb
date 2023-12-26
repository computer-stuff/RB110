# 3.times do
puts "I'm about to start a new program!"
15.times do |i| # --> 0
  puts "#{15 - i}"
  sleep 1
end
system "ruby exploring_system.rb"

puts "I'm going to sleep for 10 seconds now - bye! 👋"
sleep 160
puts "now I end"
# end

# system "pwd" # ==> /Users/nina/LSgithub/RB110/lesson_3_slightly_larger_programs
# system "cd ..; pwd" # ==>  /Users/nina/LSgithub/RB110
