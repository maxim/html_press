require 'html_press/html_press'

module Rack
  module HTMLPress
    module_function
  
    def options(options={})
      require 'html_press/rack'
      options.each_pair do |key, val|
        key = key.to_sym
        case key
        when :secret_string:  ::HTMLPress::IdentityParser.secret_string = val
        when :benchmark:      ::HTMLPress::Rack.benchmark = val
        when :store:          ::HTMLPress::Runner.store = val
        when :cache_dir:      ::HTMLPress::Store.path = val
        when :compression:    ::HTMLPress::HTMLPress.options = val
        end
      end
    end
  
    def new(*args, &blk)
      ::HTMLPress::Rack.new(*args, &blk)
    end
  end
end