require 'digest'

module HTMLPress
  class IdentityParser
    class << self
      attr_writer :auth_token_matcher, :secret_string
      
      def auth_token_matcher
        @auth_token_matcher || /(input name=["']authenticity_token["'] type=["']hidden["'] value=["'])([^"']*)/i
      end
      
      def secret_string
        @secret_string || "REPLACE_THIS_STRING_WITH_YOUR_SECRET"
      end
    end
    
    attr_reader :identifiable_html
    
    def initialize(html)
      @html = html
      extract_and_substitute_tokens
    end
    
    def id
      Digest::MD5.hexdigest(@identifiable_html)
    end
    
    def populate_tokens_into(html)
      html.gsub!(self.class.secret_string) do |match|
        @auth_tokens.shift
      end
    end
    
    private
    def extract_and_substitute_tokens
      @auth_tokens = []
      @identifiable_html = @html.gsub(self.class.auth_token_matcher) do |match|
        @auth_tokens << $2
        $1 + self.class.secret_string
      end
    end
  end
end