class UsersController < ApplicationController

  def new
  	@user = User.new
  	@user.build_location
  end

  def show
    @user = User.find(params[:id])
    @json = @user.location.to_gmaps4rails
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      flash[:success] = "Bienvenida al sitio de ANIPP!" # symbol success is converted to string before inseted in the template
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def index
    if params[:search].present?
      @locations = Location.near(params[:search], 5, :order => :distance)
    else
      @locations = Location.all
    end
  end
  
end
