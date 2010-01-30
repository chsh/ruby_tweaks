
class Object
  def class_config
    ____class_config_saver____.path self.name.underscore
  end
  private
  def ____class_config_saver____
    @@____class_config_saver____ ||= YAML.load_file("#{RAILS_ROOT}/config/class_config.yml")[RAILS_ENV]
  end
end
