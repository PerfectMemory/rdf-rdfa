require 'htmlentities'

module RDF::RDFa
  class Reader < RDF::Reader
    ##
    # REXML implementation of an XML parser.
    #
    # @see http://www.germane-software.com/software/rexml/
    module REXML
      ##
      # Returns the name of the underlying XML library.
      #
      # @return [Symbol]
      def self.library
        :rexml
      end

      # Proxy class to implement uniform element accessors
      class NodeProxy
        attr_reader :node
        attr_reader :parent

        def initialize(node, parent = nil)
          @node = node
          @parent = parent
        end

        ##
        # Element language
        #
        # From HTML5 [3.2.3.3]
        #   If both the lang attribute in no namespace and the lang attribute in the XML namespace are set
        #   on an element, user agents must use the lang attribute in the XML namespace, and the lang
        #   attribute in no namespace must be ignored for the purposes of determining the element's
        #   language.
        #
        # @return [String]
        def language
          language = case
          when @node.attribute("lang", RDF::XML.to_s)
            @node.attribute("lang", RDF::XML.to_s)
          when @node.attribute("lang")
            @node.attribute("lang").to_s
          end
        end

        ##
        # Return xml:base on element, if defined
        #
        # @return [String]
        def base
          @node.attribute("base", RDF::XML.to_s)
        end

        def display_path
          @display_path ||= begin
            path = []
            path << parent.display_path if parent
            path << @node.name
            case @node
            when ::REXML::Element   then path.join("/")
            when ::REXML::Attribute then path.join("@")
            else path.join("?")
            end
          end
        end

        ##
        # Return true of all child elements are text
        #
        # @return [Array<:text, :element, :attribute>]
        def text_content?
          @node.children.all? {|c| c.is_a?(::REXML::Text)}
        end

        ##
        # Retrieve XMLNS definitions for this element
        #
        # @return [Hash{String => String}]
        def namespaces
          ns_decls = {}
          @node.attributes.each do |name, attr|
            next unless name =~ /^xmlns(?:\:(.+))?/
            ns_decls[$1] = attr
          end
          ns_decls
        end
        
        ##
        # Children of this node
        #
        # @return [NodeSetProxy]
        def children
          NodeSetProxy.new(@node.children, self)
        end
        
        ##
        # Inner text of an element
        #
        # @see http://apidock.com/ruby/REXML/Element/get_text#743-Get-all-inner-texts
        # @return [String]
        def inner_text
          coder = HTMLEntities.new
          ::REXML::XPath.match(@node,'.//text()').map { |e|
            coder.decode(e)
          }.join
        end

        ##
        # Inner text of an element
        #
        # @see http://apidock.com/ruby/REXML/Element/get_text#743-Get-all-inner-texts
        # @return [String]
        def inner_html
          @node.children.map(&:to_s).join
        end

        ##
        # Node type accessors
        #
        # @return [Boolean]
        def element?
          @node.is_a?(::REXML::Element)
        end

        ##
        # Proxy for everything else to @node
        def method_missing(method, *args)
          @node.send(method, *args)
        end
      end

      ##
      # NodeSet proxy
      class NodeSetProxy
        attr_reader :node_set
        attr_reader :parent

        def initialize(node_set, parent)
          @node_set = node_set
          @parent = parent
        end

        ##
        # Return a proxy for each child
        #
        # @yield(child)
        # @yieldparam(NodeProxy)
        def each
          @node_set.each do |c|
            yield NodeProxy.new(c, parent)
          end
        end

        ##
        # Proxy for everything else to @node_set
        def method_missing(method, *args)
          @node_set.send(method, *args)
        end
      end

      ##
      # Initializes the underlying XML library.
      #
      # @param  [Hash{Symbol => Object}] options
      # @return [void]
      def initialize_xml(input, options = {})
        require 'rexml/document' unless defined?(::REXML)
        @doc = case input
        when ::REXML::Document
          input
        else
          # Try to detect charset from input
          options[:encoding] ||= input.charset if input.respond_to?(:charset)
          
          # Otherwise, default is utf-8
          options[:encoding] ||= 'utf-8'

          # Set xml:base for the document element, if defined
          @base_uri = base_uri ? base_uri.to_s : nil

          # Only parse as XML, no HTML mode
          doc = ::REXML::Document.new(input.respond_to?(:read) ? input.read : input.to_s)
        end
      end

      # Determine the host language and/or version from options and the input document
      def detect_host_language_version(input, options)
        @host_language = options[:host_language] ? options[:host_language].to_sym : nil
        @version = options[:version] ? options[:version].to_sym : nil
        return if @host_language && @version

        # Snif version based on input
        case input
        when ::REXML::Document
          doc_type_string = input.doctype.to_s
          version_attr = input.root && input.root.attribute("version").to_s
          root_element = input.root.name.downcase
          root_namespace = input.root.namespace.to_s
          root_attrs = input.root.attributes
          content_type = "application/xhtml+html" # FIXME: what about other possible XML types?
        else
          content_type = input.content_type if input.respond_to?(:content_type)

          # Determine from head of document
          head = if input.respond_to?(:read)
            input.rewind
            string = input.read(1000)
            input.rewind
            string.to_s
          else
            input.to_s[0..1000]
          end

          doc_type_string = head.match(%r(<!DOCTYPE[^>]*>)m).to_s
          root = head.match(%r(<[^!\?>]*>)m).to_s
          root_element = root.match(%r(^<(\S+)[ >])) ? $1 : ""
          version_attr = root.match(/version\s+=\s+(\S+)[\s">]/m) ? $1 : ""
          head_element = head.match(%r(<head.*<\/head>)mi)
          head_doc = ::REXML::Document.new(head_element.to_s)

          # May determine content-type and/or charset from meta
          # Easist way is to parse head into a document and iterate
          # of CSS matches
          ::REXML::XPath.each(head_doc, "//meta") do |e|
            if e.attribute("http-equiv").to_s.downcase == 'content-type'
              content_type, e = e.attribute("content").to_s.downcase.split(";")
              options[:encoding] = $1.downcase if e.to_s =~ /charset=([^\s]*)$/i
            elsif e.attribute("charset")
              options[:encoding] = e.attr("charset").to_s.downcase
            end
          end
        end

        # Already using XML parser, determine from DOCTYPE and/or root element
        @version ||= :"rdfa1.0" if doc_type_string =~ /RDFa 1\.0/
        @version ||= :"rdfa1.0" if version_attr =~ /RDFa 1\.0/
        @version ||= :"rdfa1.1" if version_attr =~ /RDFa 1\.1/
        @version ||= :"rdfa1.1"

        @host_language ||= case content_type
        when "application/xml"  then :xml1
        when "image/svg+xml"    then :svg
        when "text/html"
          case doc_type_string
          when /html 4/i        then :html4
          when /xhtml/i         then :xhtml1
          when /html/i          then :html5
          end
        when "application/xhtml+xml"
          case doc_type_string
          when /html 4/i        then :html4
          when /xhtml/i         then :xhtml1
          when /html/i          then :xhtml5
          end
        else
          case root_element
          when /svg/i           then :svg
          when /html/i          then :html4
          end
        end

        @host_language ||= :xml1
      end

      # Accessor methods to mask native elements & attributes
      
      ##
      # Return proxy for document root
      def root
        @root ||= NodeProxy.new(@doc.root) if @doc && @doc.root
      end
      
      ##
      # Document errors
      def doc_errors
        []
      end
      
      ##
      # Find value of document base
      #
      # @param [String] base Existing base from URI or :base_uri
      # @return [String]
      def doc_base(base)
        # find if the document has a base element
        case @host_language
        when :xhtml1, :xhtml5, :html4, :html5
          base_el = ::REXML::XPath.first(@doc, "/html/head/base") 
          base = base_el.attribute("href").to_s.split("#").first if base_el
        else
          xml_base = root.attribute("base", RDF::XML.to_s)
          base = xml_base if xml_base
        end
        
        base || @base_uri
      end
    end
  end
end
