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
      let!(:user) {FactoryGirl.create(:user)}
      let!(:location) {FactoryGirl.create(:location, user_id: user.id)}
      
      before do
        sign_in user
      end
      
      it { should have_content(user.name) }
      it { should have_link('Actualiza tu Registro', href: edit_user_path(user)) }
      it { should have_link('Salir', href: signout_path) }
      it { should_not have_link('Ingreso Instructoras', href: signin_path) }
      
      describe "followed by sign out" do
        before { click_link "Salir" }
        it { should have_link('Ingreso Instructoras')}
        it { should have_link('Registro Instructoras')}
      end
    end     
  end
  
  describe "Authorization" do
    
    describe "for non signed users" do
      
      let(:user) {FactoryGirl.create(:user)}
      
      describe "in the users controller" do
        
        describe "visiting the administration page" do
          before { visit admin_path }
          
          it { should have_selector('h2', text: 'Ingreso Instructoras')}
        end
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          
          it { should have_selector('h2', text: 'Ingreso Instructoras')}
        end
        
        describe "submitting the create action" do
          # this is another way in which capybara access a controller action
          # issuing a put action to the path (url)
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "when attempting visit a protected page" do
          before do
            visit edit_user_path(user)
            fill_in "Correo",   with: user.email
            fill_in "Password", with: user.password
            click_button "Ingresar"
          end
          
          describe "after sign in" do
            it "should redirect to the desired page" do
              should have_selector('h2', text: 'Actualiza tu Registro')
            end
          end
        end
        
      end
    end
    
    describe "as wrong user" do
      let!(:user) {FactoryGirl.create(:user)}
      let!(:location) {FactoryGirl.create(:location, user_id: user.id)}
      let!(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com")}
      let!(:wrong_location) {FactoryGirl.create(:location, user_id: wrong_user.id)}
      
      before do
        sign_in user
      end
      
      describe "visiting users Edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('h2', text: 'Actualiza tu Registro') }
      end
      
      describe "submitting a PUT request to users UPDATE" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to root_path }
      end
    end
    
     describe "as non-admin user" do
      let!(:user) {FactoryGirl.create(:user)}
      let!(:location) {FactoryGirl.create(:location, user_id: user.id)}
      let!(:non_admin) {FactoryGirl.create(:user)}
      let!(:non_admin_location) {FactoryGirl.create(:location, user_id: non_admin.id)}

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to root_path }
      end
    end
    
  end
  
end
