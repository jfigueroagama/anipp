def sign_in(user)
  # This method is to submit a valid information and sign in a user in the tests
  visit signin_path
  fill_in "Correo", with: user.email
  fill_in "Password", with: user.password
  click_button "Ingresar"
  # sign in when not using capybara as well
  cookies[:remember_token] = user.remember_token
end
