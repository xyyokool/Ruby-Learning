# system
x = system('echo hello ruby')
y = `echo hello ruby too`
z = %x{echo hello ruby too 2}

# exec "echo this is exec way"
# puts "never be here"


# if fork.nil?
#   exec "echo fork here"
# end
#
# puts "test fork"

child = fork do
  sleep 3
  puts "Childs says hi!"
end

puts "waiting childs"

Process.wait child
puts "All Done!"