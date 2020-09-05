# frozen_string_literal: true

class Wagon
  include Manufacture, InstanceCounter, Validation
  extend Accessors

  COMPANY_NAME = 'Vega Inc.'.freeze

  # attr_reader :type_wagon, :size_wagon
  attr_accessor_with_history :type_wagon, :size_wagon

  alias size size_wagon
  def initialize(size_wagon)
    @company_name = COMPANY_NAME
    @size_any     = size_wagon
  end
end
