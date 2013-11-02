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
    let!(:user) {FactoryGirl.create(:user)}
    let!(:location) {FactoryGirl.create(:location, user_id: user.id)}
    
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    
    it { should have_selector('h2', text: 'Actualiza tu Registro') }
    
    describe "with invalid information" do
      before { click_button 'Guardar Cambios' }
      
      it { should have_content('error')}
    end
  end
  
  
  describe "administration" do
    let!(:admin) {FactoryGirl.create(:admin)}
    let!(:admin_location) {FactoryGirl.create(:location, user_id: admin.id)}
    let!(:user1) {FactoryGirl.create(:user)}
    let!(:location1) {FactoryGirl.create(:location, user_id: user1.id)}
    
    before do
      sign_in admin
      visit admin_path
    end

    it { should have_selector('h2', text: 'Administrar Instructoras') }

    it "should list each user" do
      User.all.each do |u|
        page.should have_selector('li', text: u.name)
      end
    end
    
    it { should have_link('Eliminar', href: user_path(user1)) }
    
    it "should be able to delete another user" do
      expect { click_link('Eliminar') }.to change(User, :count).by(-1)
    end
    # it should not have the delete link to delete himself
    it { should_not have_link('Eliminar', href: user_path(admin)) }
  end
  
  describe "index" do
    user1 = FactoryGirl.create(:user)
    location1 = FactoryGirl.create(:location, user_id: user1.id)
    user2 = FactoryGirl.create(:user, name: "Bob", email: "bob@example.com" )
    location2 = FactoryGirl.create(:location, user_id: user2.id)
    
    before do
      visit users_path
    end
    
    it { should have_selector('h2', text: 'Busqueda') }
    
    it "it should list the users" do
     User.all.each do |user|
       page.should have_selector('td', text: user.name )
     end
    end
    
    describe "pagination" do
      before { 5.times { user = FactoryGirl.build(:user); location = FactoryGirl.build(:location, user_id: user.id ) } }
      
      it { should have_selector('table') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('td', text: user.name)
        end
      end
    end
    
  end
  
end
