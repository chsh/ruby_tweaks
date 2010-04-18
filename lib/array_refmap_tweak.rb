
class Array
  def refmap(default = nil, &block)
    keys = self.map(&block)
    hash = Hash[*[keys, self].transpose.flatten]
    return hash unless default
    hash.default = default
    hash
  end
end
