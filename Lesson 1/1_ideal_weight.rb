# Задача 1
# Идеальный вес. Программа запрашивает у пользователя имя и рост и выводит идеальный вес по формуле
# (<рост> - 110) * 1.15, после чего выводит результат пользователю на экран с обращением по имени.
# Если идеальный вес получается отрицательным, то выводится строка "Ваш вес уже оптимальный"

puts 'Введите, пожалуйста, Ваше имя:'
name = gets.force_encoding(Encoding::UTF_8).chomp.capitalize
# Русские крякозябры не решатюся ни coding, ни require 'twitter_cldr'.
# Помогает либо force_encoding(Encoding::UTF_8) либо обёртка строки String#mb_chars
# в activesupport (из состава Rails, но может использоваться отдельно).
# "name = gets.chomp.mb_chars.to_s.capitalize" (обязательно: "require 'active_support/core_ext/string/multibyte'")
# Если не обращать внимания на крякозябры, то достаточно: "name = gets.chomp.capitalize"

name = "Cpt. Nemo" if name.size == 0 # для ленивых

puts 'Введите, пожалуйста, Ваш рост (см):'
weight = gets.chomp.to_i
weight = 109 if weight <= 0 || weight > 260  # для особо остроумных

ideal_weight = (weight - 110) * 1.15

if ideal_weight < 0
  puts "#{name}, Ваш вес уже оптимальный!"
else
  puts "#{name}, Ваш идеальный вес:\n#{ideal_weight} кг"
end

# вычисление в одну строку (читается сложнее):
# puts perfect_weight > 0 ? "#{name}, Ваш идеальный вес: #{ideal_weight} кг" : "#{name}, Ваш вес уже оптимальный!"

# STDIN.getc # чтобы избежать проблем при запуске программы c переданным аргументом
# (http://ruby.qkspace.com/ruby-chem-gets-otlichaetsya-ot-stdin-gets)


