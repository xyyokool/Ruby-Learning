# analyzer完整练习1
stopwords = %w{the a by on for of are with just but and to the my I has
  some in}

lines = File.readlines(ARGV[0])

line_count = lines.size
text = lines.join

# 统计单词数量, split不传参默认一个空格
word_count = text.split.length
# 统计字符数量
character_count = text.length;
character_count_nospaces = text.gsub(/\s+/, "").length
# 统计段落
paragraph_count = text.split(/\n\n/).length
# 统计句子
sentence_count = text.split(/\.|\?|!/).length

# 统计没包含stopwords的有效字符(相当于过滤敏感词)
# scan方法接收一个正则, 会按照正则的要求拆分字符串为数组
all_words = text.scan(/\w+/)
# reject, select的反面, 如果stopwords有这个遍历的单词, 就丢弃不要
good_words = all_words.reject {|word| stopwords.include?(word)}
good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i 

# 挑出有用的句子
sentences = text.sub(/\s+/, " ").strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by {|sentence| sentence.length}
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select {|sentence| sentence =~ /is|am|are/}

# 输出结果
puts "#{line_count} lines"
puts "#{character_count} characters"
puts "#{character_count_nospaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{sentence_count / paragraph_count} sentences per paragraph
(average)"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{good_percentage}% of words are non-fluff words"
puts "Summary:\n\n" + ideal_sentences.join(". ")
puts "-- End of analysis"