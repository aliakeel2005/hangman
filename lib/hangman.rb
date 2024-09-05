# require 'pry-byebug'
require 'yaml'

class Hangman
  attr_accessor :word, :guesses_left, :current_guess

  def initialize
    @file_array = File.readlines('google-10000-english-no-swears.txt')
    @word = nil
    @guesses_left = 6
    @current_guess = nil
  end

  def does_word_match?(random)
    line = @file_array[random - 1]
    @word = line.chomp
    if @word.length >= 5 && @word.length <= 12
      p @word
      return true
    end
    false
  end

  def find_random_word
    word_found = false
    while word_found == false
      p random = rand(@file_array.size)
      word_found = does_word_match?(random)
    end
  end

  def match_guess_with_word(player_guess, arr_word)
    if arr_word.none?(player_guess)
      @guesses_left -= 1
    else
      arr_word.each_with_index do |letter, index|
        @current_guess[index] = player_guess if player_guess == letter
      end
    end
    @guesses_left
  end

  def guess_word
    puts 'Type 1 if you want to save your game'
    arr_word = @word.split('')
    p @current_guess = Array.new(arr_word.size, '_')
    while @guesses_left.positive?
      player_guess = gets.chomp.downcase
      p match_guess_with_word(player_guess, arr_word)
      p @current_guess
      break if @current_guess == arr_word || player_guess == '1'
    end
  end

  def save_game?
    puts ''
  end

  def save_game
    YAML.dump({
                word: @word,
                guesses_left: @guesses_left,
                current_guess: @current_guess
              })
  end

  def self.load_game(string)
    data = YAML.load(string)
    new(data[:word], data[:guesses_left], data[current_guess])
  end
end

game = Hangman.new
game.find_random_word
game.guess_word
p game.save_game
# Hangman.load_game(game.save_game)
