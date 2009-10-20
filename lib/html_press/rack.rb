require 'html_press/runner'

module HTMLPress
  class Rack
    class << self
      attr_writer :benchmark
      def benchmark; @benchmark || false; end
    end
    
    def initialize(app)
      @app = app
    end
  
    def call(env)
      status, headers, response = @app.call(env)
      
      result = false
      if headers["Content-Type"].include?("text\/html")
        runner = ::HTMLPress::Runner.new(response.body)
        self.class.benchmark ? runner.run_with_benchmarks! : runner.run!
        result = runner.result_html
      end
      
      [status, headers, result ? [result] : response ]
    end
  end
end