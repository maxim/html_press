require 'helper'

class TestHtmlPress < Test::Unit::TestCase
  context "When encountering" do
    setup do
      @compressor = HTMLPress::HTMLPress.new
    end
  
    context "empty text nodes" do
      setup do
        HTMLPress::HTMLPress.options = [:remove_empty_text_nodes]
        @compressor.original_html = <<-HTML
          <div>
          \t
          </div>
          
          <span></span>
          
          <div>
            \t
              <span>
                \t\t
              </span>
          </div>
        HTML
      end
      
      should "remove them" do
        assert_equal "<div></div><span></span><div><span></span></div>", @compressor.compress
      end
    end
  
    context "whitespaces in normal elements" do
      setup do
        HTMLPress::HTMLPress.options = [:cleanup_elements]
        @compressor.original_html = <<-HTML
          <h2>    This is test    
          </h2>
          
          <div>    <p>\t\t This is  
            \t\f test  </p>   </div>
        HTML
      end
      
      should "remove them" do
        assert_equal "<h2>This is test</h2><div><p>This is test</p></div>", @compressor.compress
      end
    end
  
    context "whitespaces in exception elements" do
      setup do
        HTMLPress::HTMLPress.options = [:cleanup_elements]
        @compressor.original_html = <<-HTML
          <pre> \nfoobar\t  </pre>
          <span>  foobar\n </span>
          <textarea>\t\ffoobar  \n</textarea>
          <script> window.alert("Hello\t\nWorld")</script>
        HTML
      end
      
      should "remove them" do
        assert_equal "<pre> \nfoobar\t  </pre>" + 
        "<span>foobar</span>" + 
        "<textarea>\t\ffoobar  \n</textarea>" + 
        "<script> window.alert(\"Hello\t\nWorld\")</script>", @compressor.compress
      end
    end
  
    context "style attributes" do
      setup do
        HTMLPress::HTMLPress.options = [:cleanup_style_attributes]
        @compressor.original_html = 
          "<div style=\"\n\f border-left: solid   1px \tblack;  \n margin: 0px   2px   \t\t\"></div>"
      end
      
      should "remove them" do
        assert_equal "<div style=\"border-left: solid 1px black; margin: 0px 2px\"></div>", @compressor.compress
      end
    end
  
    context "normal html comments" do
      setup do
        HTMLPress::HTMLPress.options = [:remove_comments]
        @compressor.original_html = 
          "<div></div><!-- a comment --><!-- another comment,\t\f\n\nwhich occupies >1 line --><span></span>"
      end
      
      should "remove them" do
        assert_equal "<div></div><span></span>", @compressor.compress
      end
    end
    
    context "IE html comments" do
      setup do
        HTMLPress::HTMLPress.options = [:remove_comments]
        @compressor.original_html = "<div><![if lt IE 8]><p>IE Sucks</p><![endif]></div>" +
          "<!--[if gte IE 7]><p>Thank you for closing the message box.</p><![endif]-->"
      end
      
      should "remove them" do
        assert_equal @compressor.original_html, @compressor.compress
      end
    end
  end
end
