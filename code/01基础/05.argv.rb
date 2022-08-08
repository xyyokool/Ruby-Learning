# ruby命令行参数可以使用 ARGV获取

puts p ARGV.join("-")

# ruby 05.argv.rb abc 222 --name-dev=123
# 输出 abc-222---name-dev=123
# 接收的样子: ["abc", "222", "--name-dev=123"]

# 因为接收后是数组, 所以可以通过[]直接取值,或者直接掉ARRAY相关的方法进行参数处理
puts ARGV[2]
puts ARGV.first
# --name-dev=123
# abc

# 因此客户端交互参数获取就可以这样获取
lines = File.readlines(ARGV[0])
# ruby analyzer.rb text.txt