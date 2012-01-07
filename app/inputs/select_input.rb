class SelectInput < Formtastic::Inputs::SelectInput
  
  def to_html
    template.content_tag(:dt, label_html) << 
    template.content_tag(:dd, options[:group_by] ? grouped_select_html : select_html)
  end

end