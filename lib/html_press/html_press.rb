require 'hpricot'

module HTMLPress
  class HTMLPress
    class << self
      attr_writer :options
      
      def options
        @options || [:remove_empty_text_nodes, :cleanup_elements, :cleanup_style_attributes, :remove_comments]
      end
    end
    
    attr_reader :original_html
  
    def initialize(original_html = "")
      self.original_html = original_html
    end
  
    def original_html=(html)
      @original_html = html
      @dom = Hpricot(html)
      @dom_elements = []
      @dom.traverse_all_element{|e| @dom_elements << e}
    end
  
    def compress
      self.class.options.each do |opt|
        opt = opt.to_sym
        case opt
          when :remove_empty_text_nodes: remove_empty_text_nodes!
          when :cleanup_elements: cleanup_elements!
          when :cleanup_style_attributes: cleanup_style_attributes!
          when :remove_comments: remove_comments!
        end
      end
    
      compressed_html
    end
  
    def compressed_html
      result = @dom.to_html
      if original_html.size > result.size
        result
      else
        original_html
      end
    end
  
    def remove_empty_text_nodes!
      @dom_elements.select{|e| element_empty?(e) }.map{ |e| remove_element(e) }
    end
  
    def cleanup_elements!
      @dom_elements.select do |e| 
        e.class == Hpricot::Text && !ancestors_exist?(e, "pre", "textarea", "script")
      end.map do |n|
        n.content = cleanup(n.to_s)
      end
    end
  
    def cleanup_style_attributes!
      @dom.search("//*[@style]").each do |elem| 
        elem.set_attribute("style", cleanup(elem.attributes["style"]))
      end
    end
  
    def remove_comments!
      @dom_elements.each do |elem| 
        if elem.class == Hpricot::Comment && elem.raw_string !~ /^<!(?:--)?\[/
          remove_element(elem)
        end
      end
    end
  
    private
    def element_empty?(elem)
      elem.class == Hpricot::Text && elem.to_s =~ /\A[\n\s]+\Z/
    end
  
    def remove_element(elem)
      elem.parent.children.delete(elem)
    end
  
    def ancestors_exist?(elem, *tag_names)
      if elem.parent
        return true if tag_names.include?(elem.parent.name)
        ancestors_exist?(elem.parent, *tag_names)
      else
        return false
      end
    end
  
    def cleanup(str)
      str.gsub(/\s/, " ").squeeze(" ").strip
    end
  end
end