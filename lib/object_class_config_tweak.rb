
require 'erb'

class Object
  def class_config
    ____class_config_saver____.path self.name
  end
  private
  def ____class_config_saver____(refresh = false)
    @@____class_config_saver____ = nil if refresh
    @@____class_config_saver____ ||= ClassConfig.new
  end
end

class ClassConfig
  class ChainableHash < Hash
    def self.from(hash)
      ch = ChainableHash.new
      set_hash_into_ch(hash, ch)
      ch
    end
    private
    def self.set_hash_into_ch(hash, ch)
      hash.each do |key, value|
        if value.is_a? Hash
          ch[key] = ChainableHash.from(value)
        else
          ch[key] = value
        end
        define_method_by_key(ch, key)
      end
    end
    def self.define_method_by_key(ch, key)
      if key.is_a?(String) && key =~ /^\w+$/
        ch.instance_eval do
          eval "def #{key}; self['#{key}']; end"
        end
      end
    end
  end

  def initialize
    @cc = build_chainable_hash
    @paths = {}
  end

  def path(elm_name)
    @cc.path underscore(elm_name)
  end
  def build_chainable_hash
    ChainableHash.from build_standard_hash
  end
  def build_standard_hash
    old_config = "#{config_base_path}/class_config.yml"
    if File.exist? old_config
      puts "DEPRECATION WARNING: config/class_config.yml is obsolute. Split class_config.yml into config/class_configs/*.yml"
      return hash_from_yaml(old_config, config_env)
    end
    files = Dir.glob "#{config_base_path}/class_configs/*.yml"
    yh = {}
    files.each do |file|
      h = hash_from_yaml(file, config_env)
      yh.merge! h
    end
    yh
  end
  def hash_from_yaml(filename, root_context = nil)
    return nil unless File.exist? filename
    content = File.read(filename)
    erb = ERB.new(content)
    yh = YAML.load(erb.result(binding))
    return yh unless root_context
    yh[root_context]
  end
  private
  def config_base_path
    @config_base_path ||= build_config_base_path
  end
  def build_config_base_path
    base_path = (defined? Rails) ? Rails.root : Dir.pwd
    path = File.join(base_path, 'config')
    puts "path:#{path}"
    path
  end
  def config_env
    @config_env ||= build_config_env
  end
  def build_config_env
    if defined? Rails
      Rails.env
    elsif defined? RAILS_ENV
      RAILS_ENV
    else
      ENV['RAILS_ENV']
    end
  end
  def underscore(string)
    string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end
