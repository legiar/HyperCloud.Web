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
    direction = (column.to_s == params[:sort].to_s && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
    #css_class = (column == sort_column) ? "current #{sort_direction}" : nil  
    #direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    #link_to title, {:sort => column, :direction => direction}, {:class => css_class}    
  end
end  
