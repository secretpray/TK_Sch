# 4. Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

# Вариант 1. Если массивы алфавита и гласных не нужны, то можно сразу создать, сложить их (&) -> пронумеровать
alphabet_vowels = {}

(("a".."z").to_a & 'aeiouy'.split("")).each_with_index {|letter, index| alphabet_vowels[letter] = index.next }

# Вариант 2.1 (стандартный)
alphabet = ('a'..'z').to_a
arr_vowels = ['a','e','i','o','u']  # или %w(a e i o u)
alphabet_vowels = {}

arr_vowels.each { |letter| alphabet_vowels[letter] = alphabet.index(letter) + 1 }
# alphabet.index(letter) + 1  or  alphabet.find_index(letter).next (тогда возмоожно и: alphabet = 'a'..'z')

# Вариант 2.2
# alphabet = ("a".."z").to_a
# arr_vowels = ["a", "e", "i", "o", "u", "y"]
# alphabet_vowels = {}

# alphabet.each_with_index do |letter, index|
#  alphabet_vowels[letter] = index + 1 if arr_vowels.include?(letter)
# end

# Вариант 3
# alphabet = ("a".."z").to_a
# arr_vowels = ["a", "e", "i", "o", "u", "y"]
# alphabet_vowels = {}

# i = 0 # лишняя переменная
# alphabet.each do |letter|
#  i += 1
#  alphabet_vowels[letter] = i if arr_vowels.include?(letter)
# end

# Вариант 4
# arr_vowels = 'aeiouy'.split("") # => ["a", "e", "i", "o", "u", "y"]
# alphabet = 'a'..'z'         #  range
# alphabet_vowels = {}

# arr_vowels.each { |letter| alphabet_vowels[letter] = alphabet.find_index(letter).next }

p "Гласные и их порядковый номер в английском алфавите: #{alphabet_vowels}"