require 'pry-byebug'

file_string = 'google-10000-english-no-swears.txt'
file_array = File.readlines('google-10000-english-no-swears.txt')

random = rand(file_array.size)

class Hangman
  def initialize(dict)
    @dict = dict
  end

  def find_random_word(file,file_array)
    # make flag for if word is found, set to false
    # while the flag is false do:
    # create random number
    # iterate through each word in the text
    # if the line number matches the randomly generated number
    # check if its between 5 and 12 letters
    # if yes, put the word and flag word_found as true
    # if not, redo process
    word_found = false
    while word_found == false
    p random = rand(file_array.size)
    File.foreach(file).with_index do |line,index|
      if index == random - 1
        word = line.chomp
        if word.length >= 5 && word.length <= 12
          word_found = true
          puts word
        end
      end
    end
  end
  end

end


game = Hangman.new(file_string)
game.find_random_word(file_string,file_array)
