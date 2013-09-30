require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "signup"  do

  	before do
  	  visit signup_path
  	end

  	it { should have_selector('h2', text: 'Registro')}
    it { should have_selector('title', text: 'ANIPP')}
 
  	let(:submit) { "Registrar Instructora" }

  	describe "with invalid information" do
  		it "should not create an user" do
  			expect { click_button "Registrar Instructora" }.not_to change(User, :count) # calls count method on user object
  		end
  	end

  	describe "with valid information" do
  		before do
  			fill_in "Nombre", 		with: "Michael Hart"
  			fill_in "Correo", 		with: "michael@example.com"
  			fill_in "Telefono",   with: "55 4368 6686"
  			fill_in "Password", 	with: "foobar"
  			fill_in "Confirme Password", with: "foobar"
  			fill_in "Calle y No", with: "1213 Main St."
  			fill_in "Ciudad",     with: "Mexico"
  		end
  		it "should create an user" do
  			expect { click_button "Registrar Instructora" }.to change(User, :count).by(1) # calls count method on user object
  		end
  	end

  end
  
  describe "update" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
    
    it { should have_selector('h2', text: 'Actualiza tu Registro') }
    
    describe "with invalid information" do
      before { click_button 'Guardar Cambios' }
      
      it { should have_content('error')}
    end
  end
  
end
