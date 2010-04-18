
class Array
  def refmap(opts = {}, &block)
    keys = self.map(&block)
    hash = Hash[*[keys, self].transpose.flatten]
    return hash unless opts[:default]
    hash.default = opts[:default]
    hash
  end
end
