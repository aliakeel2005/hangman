file_string = 'google-10000-english-no-swears.txt'
file_array = File.readlines('google-10000-english-no-swears.txt')

p random = rand(file_array.size)
def read_specific_line(file,number)
  # read first line
  # if does not match number
  # read second line
  # and so on
  File.foreach(file).with_index do |line,index|
    if index == number - 1
      return line
    end
  end
end

puts read_specific_line(file_string,random)
