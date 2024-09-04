require 'pry-byebug'

class Hangman
  def initialize
    @file_array = File.readlines('google-10000-english-no-swears.txt')
    @word = nil
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
    # make flag for if word is found, set to false
    # while the flag is false do:
    # create random number
    # pick line from file_array with random number
    # check if its between 5 and 12 letters
    # if yes, put the word and flag word_found as true
    # if not, redo process
    word_found = false
    while word_found == false
      p random = rand(@file_array.size)
      word_found = does_word_match?(random)
    end
  end

  def guess_word
    player_guess = gets.chomp.split('')
    p arr_word = @word.split('')
    current_guess = []
    player_guess.each_with_index do |letter, index|
      if letter == arr_word[index]
        current_guess.push(letter)
      else
        current_guess.push('_')
      end
    end
    p current_guess
  end
end

game = Hangman.new
game.find_random_word
game.guess_word
