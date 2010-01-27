
require 'md5'

# GenericUtils
module Tweaks
  module Digestable
    module ClassMethods
      def md5(file)
        raise "File doesn't exist." unless File.exist?(file)
        digester = MD5.new
        File.open(file) do |f|
          loop do
            buf = f.read(1024*1024)
            break if (buf == '' || buf.nil?)
            digester.update buf
          end
        end
        digester.hexdigest
      end
    end
  end
end


module Tweaks
  module Digestable
    def self.included(base)
      base.send(:extend, Tweaks::Digestable::ClassMethods)
    end
  end
end

File.send(:include, Tweaks::Digestable)
