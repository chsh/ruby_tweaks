# GenericUtils
module GenericSupport
  module Pathable
    module ClassMethods
      def path(hash, *pathes)
        target = hash
        pathes.map! do |p|
          p.to_s.split(/[\/\.]+/)
        end
        pathes.flatten.each do |element|
          next if (element == nil || element == '')
          key, index = parse_element__(element)
          target = target[key] || target[key.to_s]
          return nil unless target
          if index
            raise "target=#{target.inspect} is not array. but specified index value." unless target.is_a?(Array)
            target = target[index]
            return nil unless target
          end
        end
        target
      end
      
      private
      def parse_element__(elm_string)
        if elm_string =~ /^(.+)\[(\d+)\]$/
          [$1.to_sym, $2.to_i]
        elsif elm_string =~ /^(.+)_(\d+)$/
          [$1.to_sym, $2.to_i]
        else
          [elm_string.to_sym, nil]
        end
      end
    end
    module InstanceMethods
      def path(*pathes)
        self.class.path(self, *pathes)
      end
    end
  end
end


module GenericSupport
  module Hash
    def self.included(base)
      base.send(:extend, GenericSupport::Pathable::ClassMethods)
      base.send(:include, GenericSupport::Pathable::InstanceMethods)
    end
  end
end

Hash.send(:include, GenericSupport::Hash)
