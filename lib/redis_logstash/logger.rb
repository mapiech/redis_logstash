module RedisLogstash
  class Logger
    class << self

      @@options = nil

      def write(hash)
        Socket.write(filter(hash))
      end

      def filter(hash)

        if options[:truncate][:enabled]
          hash[:params] = truncate_hash(hash[:params], options[:truncate][:length])
          hash[:flash] = truncate_hash(hash[:flash], options[:truncate][:length])
        end

        hash[:params] = "#{hash[:params]}"
        hash[:flash] = "#{hash[:flash]}"

        hash

      end

      def options
        @@options ||= ParseConfig.get[:logs]
      end

      def truncate_hash(hash, length = 15)
        new_hash = {}

        hash.to_hash.each_pair do |key, value|
          if value.blank?
            new_hash[key] = ''
          elsif value.instance_of? String
            new_hash[key] = value.truncate(length)
          elsif value.instance_of? Hash
            new_hash[key] = truncate_hash(value)
          else
            new_hash[key] = '[R]'
          end
        end

        new_hash
      end

      def gzip(source, level=Zlib::DEFAULT_COMPRESSION, strategy=Zlib::DEFAULT_STRATEGY)
        output = StringIO.new("w")
        gz = Zlib::GzipWriter.new(output, level, strategy)
        gz.write(source)
        gz.close
        output.string
      end

    end
  end
end

