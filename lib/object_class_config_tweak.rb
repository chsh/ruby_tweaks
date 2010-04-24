
class Object
  def class_config
    ____class_config_saver____.path self.name.underscore
  end
  private
  def ____class_config_saver____(refresh = false)
    @@____class_config_saver____ = nil if refresh
    @@____class_config_saver____ ||= ClassConfig.new
  end

end

class ClassConfig
  def initialize
    @cc = build
  end

  def path(elm_name)
    @cc.path elm_name
  end

  def build
    old_config = "#{RAILS_ROOT}/config/class_config.yml"
    if File.exist? old_config
      puts "DEPRECATION WARNING: config/class_config.yml is obsolute. Split class_config.yml into config/class_configs/*.yml"
      return hash_from_yaml(old_config, RAILS_ENV)
    end
    files = Dir.glob "#{RAILS_ROOT}/config/class_configs/*.yml"
    yh = {}
    files.each do |file|
      h = hash_from_yaml(file, RAILS_ENV)
      yh.merge! h
    end
    yh
  end
  def hash_from_yaml(filename, root_context = nil)
    return nil unless File.exist? filename
    yh = YAML.load_file(filename)
    return yh unless root_context
    yh[root_context]
  end
end
