stopwords = %w{the a by on for of are with just but and to the my I has
  some in}

lines = File.readlines("text.txt")
line_count = lines.size
text = lines.join

# 统计字符数量, 单词数量, 段落数量, 句子数量
word_count = text.split.length
character_count = text.length
character_count_nospaces = text.gsub(/\s+/,"").length
paragraph_count = text.split(/\n\n/).length
sentence_count = text.split(/\.|\?|!/).length

# 选出不在预先设置的字符串数组里的单词, 并计算百分比
all_words = text.scan(/\w+/)
fit_words = all_words.reject {|word| stopwords.include?(word)}
fit_percentage = ((fit_words.length.to_f / all_words.length.to_f) * 100).to_i

puts "#{line_count} lines"
puts "#{character_count} characters"
puts "#{character_count_nospaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph
(average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{fit_percentage}% of words are non-fluff words"