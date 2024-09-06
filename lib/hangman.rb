require 'yaml'

class Hangman
  attr_accessor :word, :guesses_left, :current_guess

  def initialize
    @file_array = File.readlines('google-10000-english-no-swears.txt')
    @word = nil
    @guesses_left = 6
    @current_guess = nil
    @game_save = nil
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

  def save_game
    @game_save = YAML.dump({
                             word: @word,
                             guesses_left: @guesses_left,
                             current_guess: @current_guess
                           })
    File.write('saves/save.yml', @game_save)
  end

  def guess_word
    puts 'Type 1 if you want to save your game, 2 if you want to load previous save'
    arr_word = @word.split('')
    @current_guess = Array.new(arr_word.size, '_')
    while @guesses_left.positive?
      p @current_guess
      p @guesses_left
      if @current_guess == arr_word
        puts 'Congrats! you guessed the word!'
        break
      end

      player_guess = gets.chomp.downcase
      if player_guess == '1'
        save_game
        puts 'Game saved!'
        break
      elsif player_guess == '2'
        load_game('saves/save.yml')
        puts 'Game loaded!'
        arr_word = @word.split('')
        next
      end

      match_guess_with_word(player_guess, arr_word)
    end
  end

  def load_game(string)
    data = YAML.load_file(string)
    @word = data[:word]
    @guesses_left = data[:guesses_left]
    @current_guess = data[:current_guess]
  end
end

game = Hangman.new
game.find_random_word
game.guess_word
