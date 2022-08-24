# system
x = system('echo hello ruby')
y = `echo hello ruby too`
z = %x{echo hello ruby too 2}

exec "echo this is exec way"
puts "never be here"
