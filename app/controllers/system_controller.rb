class SystemController < ApplicationController
  
  def index
    add_breadcrumb "System", :system_path
    # TODO: rename view file total to index 
    render :total
  end
  
  def dashboard
  end
 
end
