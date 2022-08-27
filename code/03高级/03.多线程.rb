threads = []

10.times do
  thread = Thread.new do
    10.times { |i| print i; $stdout.flush; sleep rand(2)}
  end

  threads << thread
end

# threads.each {|thread| thread.join}
threads.each do |thread|
  puts "Thread #{thread.object_id} didn't finish in 1s" unless thread.join(1)
end

sg = Fiber.new do
  s = 0
  loop do
    square = s * s
    Fiber.yield square
    s += 1
  end
end

10.times {puts sg.resume}

# fiber

sg = Fiber.new do
  s = 0
  loop do
    square = s * s
    s += 1
    # Fiber.yield会把square的结果返回给s。
    s = Fiber.yield(square) || s
  end
end

puts sg.resume
puts sg.resume
puts sg.resume
puts sg.resume 50

# non_blocking_fiber
non_blocking = Fiber.new(blocking: false) do
  puts "Blocking Fiber ? #{Fiber.current.blocking?}"
  sleep 2
end

3.times { puts non_blocking.resume }