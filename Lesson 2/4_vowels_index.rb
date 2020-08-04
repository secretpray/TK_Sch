# 4) Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

# Вариант 1.1

alphabet = ('a'..'z').to_a
arr_vowels = ['a','e','i','o','u']            # или %w(a e i o u)
alphabet_vowels = {}

arr_vowels.each { |letter| alphabet_vowels[letter] = alphabet.index(letter) + 1 }

# Вариант 1.2
# alphabet = ("a".."z").to_a
# vowels = ["a", "e", "i", "o", "u", "y"]
# alphabet_vowels = {}

# alphabet.each_with_index do |letter, index|
#  alphabet_vowels[letter] = index + 1 if vowels.include?(letter)
#end


# Вариант 2
# alphabet = ("a".."z").to_a
# vowels = ["a", "e", "i", "o", "u", "y"]
# vowels_index = {}

# i = 0
# alphabet.each do |letter|
#  i += 1
#  vowels_index[letter] = i if vowels.include?(letter)
# end

# Вариант 3
# vowels = 'aeiouy'.split("")
# alphabet = 'a'..'z'                     #  можно и без ( ).to_a
# alphabet_vowels = {}

# vowels.each { |i| alphabet_vowels[i] = alphabet.find_index(i).next }

puts "Гласные и их порядковый номер в английском алфавите: #{alphabet_vowels}"
# print alphabet_vowels


