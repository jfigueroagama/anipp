require 'spec_helper'

describe Location do
  
  describe "location" do
  
    let(:user) { FactoryGirl.create(:user) }
    
    before do
      @location = user.build_location(street: "Division del Norte 712", city: "Mexico", state: "Distrito Federal", latitude: 19.40, longitude: -99.16, 
      center_name: "Parto Natural", user_id: user.id)
    end
    
    subject { @location }
    
    it { should respond_to(:street)}  # respond_to? takes a symbol and returns true 
    it { should respond_to(:city)} # if the object respond to a given method or attribure
    it { should respond_to(:state)}
    it { should respond_to(:longitude)}
    it { should respond_to(:latitude)}
    it { should respond_to(:center_name)}
    it { should respond_to(:user_id)}
    it { should respond_to(:user)}
    
    it { should be_valid }
    
    describe "when street is not present" do
      before { @location.street = " " }
      it { should_not be_valid }
    end
    
    describe "when street is too long" do
      before { @location.street = "a" * 71 }
      it { should_not be_valid }
    end
    
    describe "when city is not present" do
      before { @location.city = " " }
      it { should_not be_valid }
    end
    
    describe "when city is too long" do
      before { @location.city = "a" * 31 }
      it { should_not be_valid }
    end
    
    describe "when state is not present" do
      before { @location.state = " " }
      it { should_not be_valid }
    end
    
  end
  
end
