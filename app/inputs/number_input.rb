class NumberInput < Formtastic::Inputs::NumberInput
  
  def to_html
    template.content_tag(:dt, label_html) << 
    template.content_tag(:dd, builder.text_field(method, input_html_options))
  end
  
end