class UsersController < InheritedResources::Base
  
  def approve
    @user = User.find(params[:id])
    @user.approve!
    redirect_to users_path
  end
  
end
