
class Object
  def self.class_config
    @@____class_config_saver____ ||= YAML.load_file("#{RAILS_ROOT}/config/class_config.yml")
    @@____class_config_saver____.path self.to_s.underscore
  end
  def class_config
    self.class.class_config
  end
end
