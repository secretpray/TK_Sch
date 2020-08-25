class Wagon
  
  include Manufacture

  COMPANY_NAME = 'Vega Inc.'

  attr_reader :type_wagon
  
  def initialize
    @company_name = COMPANY_NAME
  end

end
