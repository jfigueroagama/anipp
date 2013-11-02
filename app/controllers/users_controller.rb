class UsersController < ApplicationController
  
  before_filter :signed_in_user, only: [:edit, :update, :destroy, :administration]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  	@user.build_location
  end
  
  def edit
    #@user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @json = @user.location.to_gmaps4rails
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Bienvenida al sitio de ANIPP!" # symbol success is converted to string before inseted in the template
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Instructora actualizada!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 5, :order => :distance)
    else
      @locations = nil
      @users = User.paginate(page: params[:page], order: 'name ASC', per_page: 5)
    end
  end
  
  def administration
    @users = User.paginate(page: params[:page], order: 'name ASC', per_page: 10)
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:alert] = "Instructora borrada del sistema!"
    redirect_to admin_path
  end
  
  private
  
  def signed_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Primero debe Ingresar"
      redirect_to signin_path
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
  
end
