# 如果循环只有一行的话, 用{}比较简洁
# 1. 用Ruby打开一个文件
# File.open("text.txt").each { |line| puts line}

# 如果循环有多行的话, 用 do end来实现
# 2. 统计文件有多少行
line_count = 0
text = ""
File.open("text.txt").each do |line|
  line_count += 1
  text += line
end

puts "We have #{line_count} lines of this text"

# 3. 统计文件有多少个字符(包括了空格)
total_character = text.length
puts "This text file has #{total_character} characters"

# 4. 统计文件有多少个字符(不包括空格)
total_character_nospaces = text.gsub(/\s+/, "").length
puts "This text file has #{total_character_nospaces} characters without space"

# 5. 统计文件有多少个单词, scan方法与split方法都可以
#    scan会返回一个经过正则捕获过后的数组, 如下匹配的方式以-连写的单词会被单独识别
total_words = text.scan(/\w+/).length
puts "This text file has #{total_words} words"

#    split默认以空格拆分,无视几个空格.
total_words = text.split.length
puts "This text file has #{total_words} words"

# 6. 统计文件有多少句子. 英文中句子以 . ? ! 结尾就算
total_sentences = text.split(/\.|\?|!/).length
puts "This text file has #{total_sentences} sentences"

# 7. 统计文件有多少个段落, 一般段落都以两个回车结尾,即 \n\n
total_paragraphs = text.split(/\n\n/).length
puts "This text file has #{total_paragraphs} paragraphs"

# 8. 计算平均每个段落有多少个句子, 每个句子有多少个单词
average_sentences_per_graph = total_sentences / total_paragraphs
puts "#{average_sentences_per_graph} sentences per paragraph in average"

average_words_per_sentence = total_words / total_sentences
puts "#{average_words_per_sentence} words per sentence in average"

# 9. ruby独有字符串自动数组化方式 %w{}
# 下方输出为 ["the", "a", "by", "on", "for", "of", "are", "with", "just", "but", "and", "to", "the", "my", "I", "has", "some", "in"]
stopwords = %w{the a by on for of are with just but and to the my I has
some in}
