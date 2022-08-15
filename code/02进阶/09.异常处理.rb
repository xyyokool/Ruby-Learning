# class Person3
#   def initialize(name)
#     raise ArgumentError, "没有输入名字" if name.empty?
#   end
# end
#
# p1 =Person3.new('');

# 异常捕获
begin
  puts 10 / 0
rescue => e
  puts "you can not divide by 0 -> #{e.class}"
end

catch(:finish) do
  1000.times do
    x = rand(1000)
    throw :finish if x == 321
  end
  # 如果没catch到， 做点啥
  puts "生成1000个随机数， 不包括321哟"
end