require 'html_press/html_press'
require 'html_press/store'
require 'html_press/identity_parser'

module HTMLPress
  class Runner
    class << self
      attr_writer :store
      
      def store
        @store || Store
      end
    end
    
    attr_reader :result_html
    
    def initialize(input_html)
      @input_html = input_html
      @store = self.class.store.new
    end
    
    def run!
      html = IdentityParser.new(@input_html)
      
      @html_checksum = html.id
      
      if @result_html = @store[@html_checksum]
        @cache_hit = true
        html.populate_tokens_into(@result_html)
      else
        @cache_hit = false
        @result_html = HTMLPress.new(html.identifiable_html).compress
        @store[@html_checksum] = @result_html
      end
    end
    
    def run_with_benchmarks!(*args, &blk)
      @compression_start = Time.now
      run!(*args, &blk)
      @compression_end = Time.now
      @cached_file_path = @store.class.path + "/#{@html_checksum}"
      defined?(RAILS_DEFAULT_LOGGER) ? RAILS_DEFAULT_LOGGER.debug(benchmark_results) : puts(benchmark_results)
    end
    
    private
    def benchmark_results
      input_size = @input_html.size.to_f
      result_size = @result_html.size.to_f
      decrease = 100 - (result_size*100.0)/input_size
      difference = input_size - result_size
      compression_time = (@compression_end - @compression_start).to_f * 1000.0

      <<-RESULTS
        
    #{@cache_hit ? 'Found in cache!' : ''}
    Cached file: #{@cached_file_path}
    
    Input size: #{"%.2f" % (input_size / 1024.0)}kb
    Output size: #{"%.2f" % (result_size / 1024.0)}kb
    Difference: #{"%.2f" % (difference / 1024.0)}kb
    Decrease: #{decrease.round}%
    Compression time: #{compression_time}ms
        
      RESULTS
    end
  end
end