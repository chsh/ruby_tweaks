
class Array
  def refmap(opts = {}, &block)
    keys = self.map(&block)
    Hash[*[keys, self].transpose.flatten]
  end
end
