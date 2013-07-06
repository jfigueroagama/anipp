require 'spec_helper'

describe "User pages" do
  subject { page }
  
  describe "signup page" do

   before { visit signup_path }

   it { should have_selector('h2', text: 'Registro')}
   it { should have_selector('title', text: 'ANIPP')}
   
  end
end
