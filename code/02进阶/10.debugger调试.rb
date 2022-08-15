require 'byebug'
i= 1
j= 0
byebug
until i > 1000000
  i *= 2
  j += 1 end
puts "i = #{i}, j = #{j}"

