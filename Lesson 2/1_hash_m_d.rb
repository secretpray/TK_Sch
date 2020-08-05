=begin
Задание 1.
Сделать хеш, содержащий месяцы и количество дней в месяце.
В цикле выводить те месяцы, у которых количество дней ровно 30
=end

month_day = {
    "январь" => 31,
    "февраль" => 28,
    "март" => 31,
    "апрель" => 30,
    "май" => 31,
    "июнь" => 30,
    "июль" => 31,
    "август" => 31,
    "сентябрь" => 30,
    "октябрь" => 31,
    "ноябрь" => 30,
    "декабрь" => 31
}

puts "Месяцы, у которых количество дней ровно 30:"

# Вариант 1.1
month_day.each { |month, days| p "- #{month}" if days == 30 }

# Вариант 1.2
# month_day.each_pair { |month, days| p "- #{month}" if days == 30 }

# Вариант 2
# month_day.each_key {|month| puts "- #{month}" if month_day[month] == 30 }

# Вариант 3
# month_day.select { |month, days| p "- #{month}" unless days != 30 }

# Вариант 4
# Свой хэш, так как требований к нему нет))))
# month_day = { 31 => ["January", " March", "May", "July", "August", "October", "December"],
#            30 => ["April", "June", "September", "November"],
#            28 => ["February"] }

# month_day[30].each { |month| p "- #{month}" }







