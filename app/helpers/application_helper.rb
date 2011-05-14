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
end
