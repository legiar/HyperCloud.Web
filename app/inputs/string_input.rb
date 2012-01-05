class StringInput < Formtastic::Inputs::StringInput
  
  #def input_wrapping(&block)
  #  template.content_tag(:p, 
  #    [template.capture(&block), error_html, hint_html].join("\n").html_safe, 
  #    wrapper_html_options
  #  )
  #end
  
  def to_html
    template.content_tag(:dt, label_html) << 
    template.content_tag(:dd, builder.text_field(method, input_html_options))
  end
end