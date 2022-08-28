class WordPlay
  def self.best_sentence(sentences, desired_words)
    # recap： ruby里， 数组相减是直接去重
    sentences.sort_by { |s| s.words.length - (s.downcase.words - desired_words).length }
  end

  def self.switch_pronouns(text)
    text.gsub(/\b(I am|You are|I|You|Me|Your|My)\b/i) do |pronoun|
      case pronoun.downcase
      when "i"
        "you"
      when "you"
        "me"
      when "me"
        "you"
      when "i am"
        "you are"
      when "you are"
        "i am"
      when "your"
        "my"
      when "my"
        "your" end
    end.sub(/^me\b/i, 'i')
  end
end

class String
  def sentences
    gsub(/\n|\r/, '').split(/\.\s*/)
  end

  def words
    scan(/\w[\w\'\-]*/)
  end
end

# test
# p %q{Hello. This is a test of
# basic sentence splitting. It
# even works over multiple lines.}.sentences

# test
# p "This is a test of words' capabilities".words

# test
# p %q{Hello. This is a test of
# basic sentence splitting. It
# even works over multiple lines}.sentences[1].words[3]

# test
hot_words = %w{test ruby great}
my_string = "This is a test. Dull sentence here. Ruby is great. So is
cake."
t = my_string.sentences.find_all do |s|
  s.downcase.words.any? {|word| hot_words.include?(word)}
end

p t.to_a # ["This is a test", "Ruby is great"]

puts WordPlay.best_sentence(my_string.sentences, hot_words)

puts WordPlay.switch_pronouns('Your cat is fighting with my cat')