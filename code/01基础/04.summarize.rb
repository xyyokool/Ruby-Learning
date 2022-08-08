text = %q{
  Ruby is a great programming language. It is object oriented
  and has many groovy features. Some people don't like it, but that's
  not our problem! It's easy to learn. It's great. To learn more about Ruby,
  visit the official Ruby website today.
  }

# 将格式化文本(带很多空格)合并成句子数组
sentences = text.gsub(/\s+/, " ").strip.split(/\.|\?|!/)
# 文本数组按照字符串长度排序, 数组和Hashes都有这个方法
sentences_sorted = sentences.sort_by {|sentence| sentence.length}
# slice(start,end), 裁剪数组或字符串,和其他语言一样
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
# select =~ 跟正则, 按正则选取字符串, 可以当作JS的filter
ideal_sentences = ideal_sentences.select {|sentence| sentence =~ /is | am | are/}

# join 拼接数组为字符串
puts ideal_sentences.join(".")