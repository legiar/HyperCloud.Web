class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :set_time_zone
  
  helper_method :sort_column, :sort_direction

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def tickets_per_page
    cookies[:tickets_per_page] || '10'
  end

  protected

    def layout_by_resource
      devise_controller? ? "devise" : "application"
    end
    
    def set_time_zone
      #Time.zone = @current_user.time_zone if @current_user
    end
    
    def sort_column
      # TODO: How get resource_class from InheritedResource  
      #resource_class.column_names.include?(params[:sort]) ? params[:sort] : resource_class.primary_key
      params[:sort] ? params[:sort] : "id"
    end  
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"  
    end      
  
end
