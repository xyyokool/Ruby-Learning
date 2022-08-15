# require 'benchmark'
#
# puts Benchmark.measure {10000.times {print "." }}
# require 'benchmark'
# iterations = 1000000
# b = Benchmark.measure do
#   for i in 1..iterations
#     x= i end
# end
# c = Benchmark.measure do
#   iterations.times do |i|
#     x= i end
# end
# puts b
# puts c

require 'benchmark'
iterations = 1000000
Benchmark.bmbm do |bmbm|
  bmbm.report("for:") do
    for i in 1..iterations
      x= i
    end
  end
  bmbm.report("times:") do
    iterations.times do |i|
      x= i end
  end
end
