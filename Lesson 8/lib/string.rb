class String
  
  # font
  def black
    "\e[30m#{self}\e[0m"
  end

  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end

  def brown
    "\e[33m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end

  def magenta
    "\e[35m#{self}\e[0m"
  end

  def cyan
    "\e[36m#{self}\e[0m"
  end

  def gray
    "\e[37m#{self}\e[0m"
  end
  
  #background
  def bg_black
    "\e[40m#{self}\e[0m"
  end

  def bg_red
    "\e[41m#{self}\e[0m"
  end

  def bg_green
    "\e[42m#{self}\e[0m"
  end

  def bg_brown
    "\e[43m#{self}\e[0m"
  end

  def bg_blue
    "\e[44m#{self}\e[0m"
  end

  def bg_magenta
    "\e[45m#{self}\e[0m"
  end

  def bg_cyan
    "\e[46m#{self}\e[0m"
  end

  def bg_gray
    "\e[47m#{self}\e[0m"
  end
  
  # style
  def bold
    "\e[1m#{self}\e[22m"
  end

  def italic
    "\e[3m#{self}\e[23m"
  end

  def underline
    "\e[4m#{self}\e[24m"
  end

  def blink
    "\e[5m#{self}\e[25m"
  end

  def reverse_color
    "\e[7m#{self}\e[27m"
  end
  
  def no_colors
    self.gsub /\e\[\d+m/, ""
  end
end

#puts "I'm back green".bg_green
#puts "I'm red and back cyan".red.bg_cyan
#puts "I'm bold and green and backround red".bold.green.bg_red
#puts "I'm back green".no_colors

=begin 
Alternative method 1
//foreground color
public static final String BLACK_TEXT()   { return "\033[30m";}
public static final String RED_TEXT()     { return "\033[31m";}
public static final String GREEN_TEXT()   { return "\033[32m";}
public static final String BROWN_TEXT()   { return "\033[33m";}
public static final String BLUE_TEXT()    { return "\033[34m";}
public static final String MAGENTA_TEXT() { return "\033[35m";}
public static final String CYAN_TEXT()    { return "\033[36m";}
public static final String GRAY_TEXT()    { return "\033[37m";}

//background color
public static final String BLACK_BACK()   { return "\033[40m";}
public static final String RED_BACK()     { return "\033[41m";}
public static final String GREEN_BACK()   { return "\033[42m";}
public static final String BROWN_BACK()   { return "\033[43m";}
public static final String BLUE_BACK()    { return "\033[44m";}
public static final String MAGENTA_BACK() { return "\033[45m";}
public static final String CYAN_BACK()    { return "\033[46m";}
public static final String WHITE_BACK()   { return "\033[47m";}

//ANSI control chars
public static final String RESET_COLORS() { return "\033[0m";}
public static final String BOLD_ON()      { return "\033[1m";}
public static final String BLINK_ON()     { return "\033[5m";}
public static final String REVERSE_ON()   { return "\033[7m";}
public static final String BOLD_OFF()     { return "\033[22m";}
public static final String BLINK_OFF()    { return "\033[25m";}
public static final String REVERSE_OFF()  { return "\033[27m";}
=end

=begin
Alternative method 2
red = 31
green = 32
blue = 34

def color (color=blue)
  printf "\033[#{color}m";
  yield
  printf "\033[0m"
end

color { puts "this is blue" }
color(red) { logger.info "and this is red" }
=end
