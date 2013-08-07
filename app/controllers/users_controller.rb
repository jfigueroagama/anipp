class UsersController < ApplicationController

  def new
  	@user = User.new
  	@user.build_location
  end

  def show
    @user = User.find(params[:id])
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
  end
  
end
