
class ArrayWithOptions < Array
  attr_accessor :options

  def initialize(array, new_options = {})
    super(array)
    @options = new_options
  end
end
