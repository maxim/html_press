require 'fileutils'
require 'tmpdir'

module HTMLPress
  class Store
    class << self
      attr_writer :path
      
      def path
        @path || (defined?(RAILS_ROOT) ? File.join(RAILS_ROOT, "tmp/htmlpress") : Dir.tmpdir)
      end
    end
    
    def [](key)
      filepath = File.join(self.class.path, key)
      File.exist?(filepath) ? File.read(filepath) : nil
    end
    
    def []=(key, value)
      FileUtils.mkdir_p(self.class.path) unless File.exist?(self.class.path)
      File.open(File.join(self.class.path, key), "w") do |file|
        file.write value
      end
    end
  end
end