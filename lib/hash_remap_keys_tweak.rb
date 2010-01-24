

class Hash
  def remap_keys(&block)
    raise "Block must be given." unless block_given?
    new_hash = {}
    self.each do |key, value|
      new_hash[yield(key, value) || key] = value
    end
    new_hash
  end
  def remap_keys!(&block)
    new_hash = self.remap_keys(&block)
    self.clear
    self.update new_hash
  end
end
