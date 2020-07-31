class Hello
  def hi
    puts 'Hello, world!'
  end
end

speak = Hello.new
speak.hi

class HelloPlus

  def initialize (name)
    @name = name
  end
  
  # def hello_alex
  #  puts "Hello, #{@name}!"
  # end
  
  #	def hello_aleks (name) 
  #		puts "Hello, " + name                     # => Hello, Aleks! 
  # end

  # @param [Object] name
  def hello_alex (name = nil)
    puts "Hello, #{@name} & #{name} -> init and param" # => Hello, Alex & Aleks!
  end
end

hi = HelloPlus.new ('Alex')
hi.hello_alex	# => Hello, Alex!
hi.hello_alex ("Aleks!") # => Hello, Aleks (param)!