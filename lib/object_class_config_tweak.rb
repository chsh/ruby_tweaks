
class Object
  def class_config
    ____class_config_saver____.path self.to_s.underscore
  end
  private
  def ____class_config_saver____
    @@____class_config_saver____ ||= YAML.load_file("#{RAILS_ROOT}/config/class_config.yml")[RAILS_ENV]
  end
end

class ClassConfig
  def self.[](class_name)
    ____class_config_saver____.path class_name.to_s.underscore
  end
end
