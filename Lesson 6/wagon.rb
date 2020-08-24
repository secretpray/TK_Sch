class Wagon
  
  attr_reader :type_wagon

  include Manufacture

  def initialize
     @company_name = 'Vega Inc.'
  end
end
