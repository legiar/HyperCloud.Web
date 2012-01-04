module Breadcrumbs

  class Builder
    def initialize(context, elements, options = {})
      @context  = context
      @elements = elements || []
      @options  = options
    end

    def render
      raise NotImplementedError
    end

    protected

    def compute_name(element)
      case name = element.name
      when Symbol
        @context.send(name)
      when Proc
        name.call(@context)
      else
        name.to_s
      end
    end

    def compute_path(element)
      case path = element.path
      when Symbol
        @context.send(path)
      when Proc
        path.call(@context)
      when Hash
        @context.url_for(path)
      else
        path.to_s
      end
    end
  end

  class SimpleBuilder < Builder

    def render
      @elements.collect do |element|
        render_element(element)
      end.join(@options[:separator] || " &raquo; ")
    end

    def render_element(element)
      content = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options)
      out = if @options[:tag]
        @context.content_tag(@options[:tag], content)
      else
        content
      end
      if @options[:suffix]
        out << @options[:suffix].html_safe 
      end
      out
    end
  end

  class Element
    attr_accessor :name
    attr_accessor :path
    attr_accessor :options

    def initialize(name, path, options = {})
      self.name     = name
      self.path     = path
      self.options  = options
    end
  end
end

module Breadcrumbs
  
  module ControllerExt
    extend ActiveSupport::Concern

    included do
    #  extend ClassMethods
    #  include InstanceMethods
      helper_method :add_breadcrumb, :breadcrumbs
      helper HelperMethods
    end

    module Utils
      def self.instance_proc(string)
        if string.kind_of?(String)
          proc { |controller| controller.instance_eval(string) }
        else
          string
        end
      end

      # This is an horrible method with an horrible name.
      #
      #   convert_to_set_of_strings(nil, [:foo, :bar])
      #   # => nil
      #   convert_to_set_of_strings(true, [:foo, :bar])
      #   # => ["foo", "bar"]
      #   convert_to_set_of_strings(:foo, [:foo, :bar])
      #   # => ["foo"]
      #   convert_to_set_of_strings([:foo, :bar, :baz], [:foo, :bar])
      #   # => ["foo", "bar", "baz"]
      #
      def self.convert_to_set_of_strings(value, keys)
        if value == true
          keys.map(&:to_s).to_set
        elsif value
          Array(value).map(&:to_s).to_set
        end
      end
    end

    module ClassMethods
      def add_breadcrumb(name, path, filter_options = {})
        # This isn't really nice here
        if eval = Utils.convert_to_set_of_strings(filter_options.delete(:eval), %w(name path))
          name = Utils.instance_proc(name) if eval.include?("name")
          path = Utils.instance_proc(path) if eval.include?("path")
        end

        before_filter(filter_options) do |controller|
          controller.send(:add_breadcrumb, name, path)
        end
      end
    end

    module InstanceMethods
      protected

      def add_breadcrumb(name, path, options = {})
        self.breadcrumbs << Breadcrumbs::Element.new(name, path, options)
      end

      def breadcrumbs
        @breadcrumbs ||= []
      end
    end

    module HelperMethods
      def render_breadcrumbs(options = {}, &block)
        builder = (options.delete(:builder) || Breadcrumbs::SimpleBuilder).new(self, breadcrumbs, options)
        content = builder.render.html_safe
        if block_given?
          capture(content, &block)
        else
          content
        end
      end
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  include Breadcrumbs::ControllerExt
end
