module SitesHelper
  
  def section(*args, &block)
    options = args.extract_options!
    title = args.empty? ? "" : args.first
    out = content_tag(:h2, title)
    out = content_tag(:header, out)
    out = out + content_tag(:section, capture(&block))
    options[:class] = [options[:class], "portlet leading"].flatten.compact
    options[:class] << "grid_12" unless options[:class].join(" ").match(/grid_\d+/) 
    content_tag(:section, out, :class => options[:class].join(" "))
  end
  
  def workspace(*args, &block)
    options = args.extract_options!
    title = args.empty? ? controller.controller_name.titleize : args.first
    out = content_tag(:header, :class => "container_12 clearfix") do
      content_tag(:div, :class => "grid_12") do
        content_tag(:h1, title)
        # TODO: Render breadcrumbs
        #%ul#breadcrumbs
        #  %li= link_to "Home", root_path
        #  = render_breadcrumbs :tag => :li, :separator => ''
        
        # TODO: Render shortcuts
        #%ul.shortcuts
        #  = render_shortcuts :tag => :li, :separator => ''
      end
    end
    out = out + content_tag(:section, out, :class => "container_12 clearfix") do
      content_tag(:section, :class => "grid_12") do
        render("layouts/flashes")
      end + capture(&block)
    end
  end
  
end
