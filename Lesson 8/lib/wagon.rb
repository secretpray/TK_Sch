class Wagon
  include Manufacture

  COMPANY_NAME = 'Vega Inc.'

  attr_reader :type_wagon,
              :size_wagon

  alias size size_wagon
  def initialize(size_wagon)
    @company_name = COMPANY_NAME
    @size_any     = size_wagon
  end
end
