class UsersController < ApplicationController

  def new
  	@user = User.new
  	@user.build_location
  end
  
  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
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
      @users = User.order("name ASC")
    end
  end
  
end
