require 'spec_helper'

describe "Authentication Pages" do
  
  subject { page }
  
  describe "Sign in" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button "Ingresar"}
      
      it { should have_selector('h2', text: 'Ingreso Instructoras') }
      #it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do
        before { click_link 'ANIPP' }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        location = user.build_location(street: "Division del Norte 712", city: "Mexico", state: "Distrito Federal", latitude: 19.40, longitude: -99.16, 
        center_name: "Parto Natural", user_id: user.id)
        
        fill_in "Correo",   with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Ingresar"
      end
      
      #it { should have_content(user.name) }
      #it { should have_link('Actualiza tu Registro', href: user_path(user)) }
      #it { should have_link('Salir', href: signout_path) }
      #it { should_not have_link('Ingreso Instructoras', href: signin_path) }
      
      describe "followed by sign out" do
        before { click_link "Salir" }
        #it { should have_link('Ingreso Instructoras')}
      end
    end     
  end
end
