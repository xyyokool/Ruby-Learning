require 'yaml'
require_relative 'bot_data_to_yaml'

class Bot
  attr_reader :name

  # 初始化时，传入参数， 读取文件里的：data_file, 如果报错， 则rescue错误
  def initialize(options)
    @name = options[:name] || "Unnamed Bot"
    begin
      @data = YAML.load(File.read(options[:data_file]))
    rescue
      raise "Can't load bot data"
    end
  end

  # 下面这两种方式都是传递参数， 不带括号后面变量值，就是传递参数
  def greeting
    random_response :greeting
  end

  def farewell
    random_response(:farewell)
  end

  def response_to(input)
    prepared_input = preprocess(input.downcase)
    sentence = best_sentence(prepared_input)
    responses = possible_responses(sentence)
    responses[rand(responses.length)]
  end

  private

  def random_response(key)
    random_index = rand(@data[:responses][key].length)
    @data[:responses][key][random_index].gsub(/\[name]/, @name)
  end

  def preprocess(input)
    perform_substitutions input
  end

  def perform_substitutions(input)
    @data[:presubs].each { |str| input.gsub!(str[0], str[1]) }
    input
  end

  def best_sentence(input)
    hot_words = @data[:responses].keys.select do |key|
      key.class == String && key =~ /^\w+$/
    end
    WordPlay.best_sentence(input.sentences, hot_words);
  end

  def possible_responses(sentence)
    responses = []

    @data[:responses].keys.each do |pattern|
      # 如果pattern是String的子类，则继续往下， 否则跳过
      next unless pattern.is_a?(String)

      if sentence.match('\b' + pattern.gsub(/\*/, '') + '\b')
        response << @data[:responses][pattern]
      end
    end
    # 如果respones数组为空，那就把默认的加进去
    responses << @data[:responses][:default] if responses.empty?
    # 压平数组返回
    responses.flatten
  end
end