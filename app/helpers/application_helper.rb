module ApplicationHelper
  def table_columns(names)
    out = ['<th class="check">&nbsp;</th>']
    out << names.collect do |name|
      "<th" + (name == "options" ? ' class="options"' : '') + ">" + name.humanize  + "</th>"
    end
    unless names.include?("options")
      out << '<th class="action">Actions</th>'
    end
    out.flatten.join.html_safe
  end
  
  def sortable(column, title = nil)
    title ||= column.to_s.titleize
    css_class = (column.to_s == sort_column) ? "current #{sort_direction}" : nil  
    direction = (column.to_s == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}    
  end
end  
