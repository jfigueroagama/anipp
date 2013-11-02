module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user # invokes the setter
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def signed_in?
    !current_user.nil? # if current_user is not nil, there is a user signed in
  end
  
  def is_admin?
    current_user.admin? # if current_user is admin
  end

  # current_user setter
  def current_user=(user)
    @current_user = user
  end
  
  # current_user getter
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  # check current_user
  def current_user?(user)
    user == current_user
  end
  
  # stores request url
  def store_location
    session[:return_to] = request.url
  end
  
  # redirects to the requested url once the user sign in
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
end
