class ProductsController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Products", :products_path
  
  protected
  
    def collection
      @products ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end
