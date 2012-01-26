module DashboardHelper
  def display_summary(scope)
    out = content_tag(:strong, scope.count, :class => "stats-count")
    out << content_tag(:p, scope.name.pluralize.titleize)
    out << link_to("View", url_for(scope), :class => "button stats-view tooltip")
    content_tag(:li, out) 
  end
end