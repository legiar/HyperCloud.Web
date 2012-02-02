class UsersController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Users", :users_path
  
  def approve
    @user = User.find(params[:id])
    @user.approve!
    redirect_to users_path
  end
  
  protected
  
    def collection
      @users ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end
